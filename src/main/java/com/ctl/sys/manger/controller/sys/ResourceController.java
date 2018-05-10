package com.ctl.sys.manger.controller.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ctl.sys.manger.controller.base.BaseController;
import com.ctl.sys.manger.framework.constant.GlobalConstant;
import com.ctl.sys.manger.mapper.SysResourceMapper;
import com.ctl.sys.manger.pageModel.base.Json;
import com.ctl.sys.manger.pageModel.base.SessionInfo;
import com.ctl.sys.manger.pageModel.base.Tree;
import com.ctl.sys.manger.pageModel.sys.Resource;
import com.ctl.sys.manger.po.SysResource;
import com.ctl.sys.manger.po.SysResourceExample;
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController {

//	@Autowired
//	private ResourceServiceI resourceService;
	@Autowired
	private SysResourceMapper sysResourceMapper;
	@RequestMapping("/manager")
	public String manager() {
		return "/admin/resource";
	}

	@RequestMapping("/tree")
	@ResponseBody
	public List<Tree> tree(HttpSession session) {
		Set<String> setName=new HashSet<String>();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute(GlobalConstant.SESSION_INFO);
		//mybatis start
		List<Tree> lt = new ArrayList<Tree>();
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("resourcetype", "0");//数字0不识别因此用字符串
		List<Resource> l=null;
		if (sessionInfo != null) {
			if ("admin".equals(sessionInfo.getLoginname())) {
				l = sysResourceMapper.treeGrid(map);
			} else {
				map.put("userId", Integer.valueOf(sessionInfo.getId()));// 自查自己有权限的资源
				l = sysResourceMapper.setTreeByPrivilege(map);
			}
		} else {
			return null;
		}
		if ((l != null) && (l.size() > 0)) {
			for (Resource r : l) {
				int size=setName.size();
				String name=r.getName();
				setName.add(name);
				if(setName.size()==size){//一个用户可能多个角色，且角色对应的主菜单重合  ，因为查询的都是菜单不涉及到按钮,所以一级二级菜单都不能重复，但是按钮可以重复
					continue;
				}
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				if (r.getPid() != null) {
					tree.setPid(r.getPid().toString());
				} else {
					tree.setState("closed");
				}
				tree.setText(r.getName());
				tree.setIconCls(r.getIcon());
				Map<String, Object> attr = new HashMap<String, Object>();
				attr.put("url", r.getUrl());
				tree.setAttributes(attr);
				lt.add(tree);
			}
		}
		return lt;
		//mybatis stop
		//return resourceService.tree(sessionInfo);
	}

	@RequestMapping("/allTree")
	@ResponseBody
	public List<Tree> allTree(boolean flag) {// true获取全部资源,false只获取菜单资源
		//mybatis start
		List<Tree> lt = new ArrayList<Tree>();
		Map<String ,Object> map=new HashMap<String ,Object> ();
		if(flag){
			
		}else{
			map.put("resourcetype", "0");//数字0不识别因此用字符串
		}
		List<Resource> l = sysResourceMapper.treeGrid(map);
		if ((l != null) && (l.size() > 0)) {
			for (Resource r : l) {
				if(r.getCstate()!=null&&1==r.getCstate()){//如果资源状态为1则不可以授权，admin用户可以看到该资源
					continue;
				}
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				if (r.getPid()!= null) {
					tree.setPid(String.valueOf(r.getPid()));
				}
				tree.setText(r.getName());
				tree.setIconCls(r.getIcon());
				if(r.getPid()==null){
					tree.setState("closed");
				}
				Map<String, Object> attr = new HashMap<String, Object>();
				attr.put("url", r.getUrl());
				tree.setAttributes(attr);
				lt.add(tree);
			}
		}
		return lt;
		//mybatis stop
		//return resourceService.listAllTree(flag);
	}

	@RequestMapping("/treeGrid")
	@ResponseBody
	public List<Resource> treeGrid() {
		return sysResourceMapper.treeGrid(null);//mybatis
		//return resourceService.treeGrid();
	}

	@RequestMapping("/get")
	@ResponseBody
	public Resource get(Integer id) {
		//mybatis start
		Map<String ,Object> map=new HashMap<String ,Object> ();
		List<Resource> l = sysResourceMapper.treeGrid(map);
		return l.get(0);
		//mybatis stop
		//return resourceService.get(id);
	}

	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Integer id) {
		//mybatis start
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("id", id);
		List<Resource> l = sysResourceMapper.treeGrid(map);
		request.setAttribute("resource", l.get(0));
		//mybatis stop
		//Resource r = resourceService.get(id);
		//request.setAttribute("resource", r);
		return "/admin/resourceEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Resource resource) throws InterruptedException {
		Json j = new Json();
		try {
			//如果描述为空,那么设置描述的值为name
			if(resource.getDescription()==null||"".equals(resource.getDescription().trim())){
				resource.setDescription(resource.getName());
			}
			if(resource.getResourcetype()==0){//菜单类型需要检测名字是否重复  
				SysResourceExample sysResourceExample=new SysResourceExample();
				sysResourceExample.createCriteria().andNameEqualTo(resource.getName());
				List<SysResource> selectByExample = sysResourceMapper.selectByExample(sysResourceExample);
				if(selectByExample.size()>=1&&(!selectByExample.get(0).getId().equals(resource.getId()))){
					j.setSuccess(false);
					j.setMsg("资源名称已经存在,添加失败！");
					return j;
				}
			}
			//mybatis start
			SysResource sysResource=new SysResource();
			BeanUtils.copyProperties(resource, sysResource);
			sysResource.setState(resource.getCstate());
			sysResource.setId(resource.getId());
			if(resource.getPid()!=null){
				sysResource.setPid(resource.getPid());
			}
			 sysResourceMapper.updateByPrimaryKeySelective(sysResource);
			 List<Integer> listIdsAll=new ArrayList<Integer>(20);
			 getIdByPid(listIdsAll,resource.getId());
			 int length=listIdsAll.size();
			 for(int i=0;i<length;i++){
					SysResource sysResourceChild=new SysResource();
					sysResourceChild.setId(listIdsAll.get(i));
					sysResourceChild.setState(resource.getCstate());
					sysResourceMapper.updateByPrimaryKeySelective(sysResourceChild);
			 }
			//mybatis end
			//resourceService.edit(resource);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	public void getIdByPid( List<Integer> listIdsAll,Integer id){
		List<Integer> idList=sysResourceMapper.selectIdByPid(id);//根据id获取子机构id
		if(idList!=null&&idList.size()>0){
			for(int i=0;i<idList.size();i++){
				Integer idchild=idList.get(i);
				listIdsAll.add(idchild);
				getIdByPid(listIdsAll,idchild);
			}
		}
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		Json j = new Json();
		try {
			//mybatis start
			Map<String ,Object> map=new HashMap<String ,Object> ();
			map.put("id", id);
			int num = sysResourceMapper.resourceUnionRoleNum(map);//mybatis 组织接口关联的user个数
			if(num>0){
				j.setMsg("该资源已经分配不能删除！");
				j.setSuccess(true);
				return j;
			}
			List<Integer> idListAll=new ArrayList<Integer>();
			idListAll.add(id);
			CanDeleteRes canDel=new CanDeleteRes();
			canDel.result=true;//默认可以删除
			getIdByPid(idListAll,id,canDel);
			if(canDel.result){
				for(int i=0;i<idListAll.size();i++){
					sysResourceMapper.deleteByPrimaryKey(idListAll.get(i));//mybatis
				}
			}else{
				j.setMsg("该资源或下级资源已经分配角色不能删除");
				j.setSuccess(true);
				return j;
			}
			//mybatis end
			//resourceService.delete(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	public void getIdByPid( List<Integer> listIdsAll,Integer id,CanDeleteRes canDel){
		if(!canDel.result){//
			return;
		}
		List<Integer> idList=sysResourceMapper.selectIdByPid(id);//根据id获取子机构id
		if(idList!=null&&idList.size()>0){
			for(int i=0;i<idList.size();i++){
				Integer idchild=idList.get(i);
				Map<String ,Object> map=new HashMap<String ,Object> ();
				map.put("id", idchild);
				Integer num = sysResourceMapper.resourceUnionRoleNum(map);//mybatis 组织接口关联的user个数
				if(num!=null&&num>0){//如果子机构有关联用户 则不能删除
					canDel.result=false;
					return;
				}
				listIdsAll.add(idchild);
				getIdByPid(listIdsAll,idchild,canDel);
			}
		}
	}
	class CanDeleteRes{
		boolean result;

		public boolean isResult() {
			return result;
		}

		public void setResult(boolean result) {
			this.result = result;
		}
	}
	@RequestMapping("/addPage")
	public String addPage() {
		return "/admin/resourceAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(Resource resource) {
		Json j = new Json();
		try {
			//如果描述为空,那么设置描述的值为name
			if(resource.getDescription()==null||"".equals(resource.getDescription().trim())){
				resource.setDescription(resource.getName());
			}
			if(resource.getResourcetype()==0){//菜单类型需要检测名字是否重复  
				SysResourceExample sysResourceExample=new SysResourceExample();
				sysResourceExample.createCriteria().andNameEqualTo(resource.getName());
				if(sysResourceMapper.selectByExample(sysResourceExample).size()>=1){
					j.setSuccess(false);
					j.setMsg("资源名称已经存在,添加失败！");
					return j;
				}
			}
			//mybatis start
			SysResource sysResource = new SysResource();
			BeanUtils.copyProperties(resource, sysResource);
			sysResource.setCreatedatetime(new Date());
			if ((resource.getPid() != null) && !"".equals(resource.getPid())) {
				sysResource.setPid(resource.getPid());
			}
			sysResource.setState(resource.getCstate());
			sysResource.setIsdefault(1);//1非默认资源可以删除，0默认资源不可以删除
			sysResource.setHasChild(0);//默认不是http链接地址
			sysResourceMapper.insertSelective(sysResource);
			//mybatis end
			//resourceService.add(resource);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

}
