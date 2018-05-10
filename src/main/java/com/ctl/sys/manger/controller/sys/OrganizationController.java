package com.ctl.sys.manger.controller.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ctl.sys.manger.controller.base.BaseController;
import com.ctl.sys.manger.mapper.SysOrganizationMapper;
import com.ctl.sys.manger.mapper.SysUserMapper;
import com.ctl.sys.manger.pageModel.base.Json;
import com.ctl.sys.manger.pageModel.base.Tree;
import com.ctl.sys.manger.pageModel.sys.Organization;
import com.ctl.sys.manger.po.SysOrganization;
import com.ctl.sys.manger.service.base.ServiceException;

@Controller
@RequestMapping("/organization")
public class OrganizationController extends BaseController {
	static Logger logger = LoggerFactory.getLogger(OrganizationController.class);

//	@Autowired
//	private OrganizationServiceI organizationService;
	
	@Autowired
	private SysOrganizationMapper sysOrganizationMapper;
	
	@RequestMapping("/manager")
	public String manager() {
		return "/admin/organization";
	}
	@Autowired
	private SysUserMapper sysUserMapper;
	
	@RequestMapping("/treeGrid")
	@ResponseBody
	public List<Organization> treeGrid() {
		return sysOrganizationMapper.treeGrid(null);//mybatis
		//return organizationService.treeGrid();
	}

	@RequestMapping("/tree")
	@ResponseBody
	public List<Tree> tree() {
		//mybatis start
		List<Organization> l = null;
		List<Tree> lt = new ArrayList<Tree>();
		l=sysOrganizationMapper.treeGrid(null);
		if ((l != null) && (l.size() > 0)) {
			for (Organization r : l) {
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				tree.setPid(String.valueOf(r.getPid()));
				tree.setText(r.getName());
				tree.setIconCls(r.getIcon());
				lt.add(tree);
			}
		}
		return lt;
		//mybatis end
		//return organizationService.tree();
	}

	@RequestMapping("/addPage")
	public String addPage() {
		return "/admin/organizationAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(Organization organization) {
		Json j = new Json();
		try {
			//mybatis start
			organization.setCreatedatetime(new Date());
			organization.setIsdefault(1);//1非默认机构可以删除该机构
			SysOrganization sysOrganization=new SysOrganization();
			BeanUtils.copyProperties(organization, sysOrganization);
			if(organization.getPid()!=null){//有父机构
				sysOrganization.setPid(organization.getPid());
			}
			sysOrganizationMapper.insert(sysOrganization);
			//mybatis end
			//organizationService.add(organization);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			logger.error("添加组织结构错误:"+e);
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/get")
	@ResponseBody
	public Organization get(Long id) {
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("id", id);
		return sysOrganizationMapper.treeGrid(map).get(0);//mybatis
		//return organizationService.get(id);
	}

	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Long id) {
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("id", id);
		Organization o = sysOrganizationMapper.treeGrid(map).get(0);//mybatis
		//organizationService.get((long)id);
		request.setAttribute("organization", o);
		return "/admin/organizationEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Organization org) throws InterruptedException {
		Json j = new Json();
		try {
			//mybatis start
			org.setCreatedatetime(new Date());
			org.setIsdefault(1);//1非默认机构可以删除该机构
			SysOrganization sysOrganization=new SysOrganization();
			BeanUtils.copyProperties(org, sysOrganization);
			if(org.getPid()!=null&& !"".equals(org.getPid())){//有父机构
				sysOrganization.setPid(org.getPid());
			}
			//sysOrganization.setId(org.getPid());
			sysOrganizationMapper.updateByPrimaryKeySelective(sysOrganization);
			//mybatis end
			//organizationService.edit(org);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		Json j = new Json();
		try {
			//mybatis start
			Map<String ,Object> map=new HashMap<String ,Object> ();
			map.put("id", id);
			int num = sysOrganizationMapper.organizationUnionUserNum(map);//mybatis 组织接口关联的user个数
			if(num>0){
				throw new ServiceException("该部门下面存在用户不能删除");
			}
			List<Integer> idListAll=new ArrayList<Integer>();
			idListAll.add(id);
			CanDeleteOrg canDel=new CanDeleteOrg();
			canDel.result=true;//默认可以删除
			getIdByPid(idListAll,id,canDel);
			if(canDel.result){
				for(int i=0;i<idListAll.size();i++){
					sysOrganizationMapper.deleteByPrimaryKey(idListAll.get(i));//mybatis
				}
			}else{
				throw new ServiceException("该部门或子部门存在用户不能删除");
			}
			//mybatis end
			//organizationService.delete(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (ServiceException e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	public void getIdByPid( List<Integer> listIdsAll,Integer id,CanDeleteOrg canDel){
		if(!canDel.result){//
			return;
		}
		List<Integer> idList=sysOrganizationMapper.selectIdByPid(id);//根据id获取子机构id
		if(idList!=null&&idList.size()>0){
			for(int i=0;i<idList.size();i++){
				Integer idchild=idList.get(i);
				Map<String ,Object> map=new HashMap<String ,Object> ();
				map.put("id", idchild);
				Integer num = sysOrganizationMapper.organizationUnionUserNum(map);//mybatis 组织接口关联的user个数
				if(num!=null&&num>0){//如果子机构有关联用户 则不能删除
					canDel.result=false;
					return;
				}
				listIdsAll.add(idchild);
				getIdByPid(listIdsAll,idchild,canDel);
			}
		}
	}
}
class CanDeleteOrg{
	boolean result;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}
}