package com.ctl.sys.manger.controller.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ctl.sys.manger.controller.base.BaseController;
import com.ctl.sys.manger.mapper.SysRoleMapper;
import com.ctl.sys.manger.mapper.SysRoleResourceMapper;
import com.ctl.sys.manger.pageModel.base.Grid;
import com.ctl.sys.manger.pageModel.base.Json;
import com.ctl.sys.manger.pageModel.base.PageFilter;
import com.ctl.sys.manger.pageModel.base.Tree;
import com.ctl.sys.manger.pageModel.sys.Role;
import com.ctl.sys.manger.po.SysRole;
import com.ctl.sys.manger.po.SysRoleExample;
import com.ctl.sys.manger.po.SysRoleResourceExample;
import com.ctl.sys.manger.po.SysRoleResourceKey;
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

//	@Autowired
//	private RoleServiceI roleService;
	
	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Autowired
	private SysRoleResourceMapper sysRoleResourceMapper;
	@RequestMapping("/manager")
	public String manager() {
		return "/admin/role";
	}

	@RequestMapping("/dataGrid")
	@ResponseBody
	public Grid dataGrid(Role role, PageFilter ph) {
		Grid grid = new Grid();
		//mybatis start
		Long totalRow = sysRoleMapper.countByParameter(role);
		List<Role> dataList = sysRoleMapper.selectByParameter(role);
		grid.setRows(dataList);
		grid.setTotal(totalRow);
		//mybatis end
//		grid.setRows(roleService.dataGrid(role, ph));
//		grid.setTotal(roleService.count(role, ph));
		return grid;
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<Tree> tree() {
		//mybatis start
		
		List<SysRole> l = null;
		List<Tree> lt = new ArrayList<Tree>();
		SysRoleExample sysRoleExample=new SysRoleExample();
		sysRoleExample.createCriteria();
		l=sysRoleMapper.selectByExample(sysRoleExample);
		if ((l != null) && (l.size() > 0)) {
			for (SysRole r : l) {
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				tree.setText(r.getName());
				lt.add(tree);
			}
		}
		return lt;
		//mybatis start
		//return roleService.tree();
	}
	
	@RequestMapping("/addPage")
	public String addPage() {
		return "/admin/roleAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(Role role) {
		Json j = new Json();
		try {
			//mybatis start
			SysRole sysRole=new SysRole();
			BeanUtils.copyProperties(role, sysRole);
			sysRole.setIsdefault(1);
			sysRoleMapper.insert(sysRole);
			//mybatis end
			//roleService.add(role);
			j.setSuccess(true);
			j.setMsg("添加成功！");
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
			sysRoleMapper.deleteByPrimaryKey(id);
			SysRoleResourceExample sysRoleResourceExample=new SysRoleResourceExample();
			sysRoleResourceExample.createCriteria().andRole_idEqualTo(id);
			sysRoleResourceMapper.deleteByExample(sysRoleResourceExample);
			//mybatis end
			//roleService.add(role);
			//roleService.delete(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/get")
	@ResponseBody
	public Role get(Integer id)  {
		//mybatis start
		SysRole sysRole=sysRoleMapper.selectByPrimaryKey(id);
		Role role =new Role();
		BeanUtils.copyProperties(role, sysRole);
		role.setId(id);
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("role_id", id);
		List<Map<String, Object>> listSysResourceByRoleId=sysRoleMapper.getResoureIdNameByRoleId(map);
		if ((listSysResourceByRoleId != null) && !listSysResourceByRoleId.isEmpty()) {
			boolean b = false;
			StringBuilder ids = new StringBuilder();
			StringBuilder names = new StringBuilder();
			for (Map<String, Object> mapIdName : listSysResourceByRoleId) {
				if (b) {
					ids.append(",");
					names.append(",");
				} else {
					b = true;
				}
				ids.append(mapIdName.get("id"));
 				names.append(mapIdName.get("name"));
			}
			role.setResourceIds(ids.toString());
			role.setResourceNames(names.toString());
		}
		//mybatis end
		return role;
		//return roleService.get(id);
	}
	
	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Integer id) {
		request.setAttribute("role", sysRoleMapper.selectByPrimaryKey(id));
		//Role r = roleService.get(id);
		//request.setAttribute("role", r);
		return "/admin/roleEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Role role) {
		Json j = new Json();
		try {
			//mybatis start
			SysRole sysRole=new SysRole();
			BeanUtils.copyProperties(role, sysRole);
			sysRole.setId(role.getId());
			sysRoleMapper.updateByPrimaryKeySelective(sysRole);
			//mybatis end
			//roleService.edit(role);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/grantPage")
	public String grantPage(HttpServletRequest request, Integer id) {
		//mybatis start
		SysRole sysRole=sysRoleMapper.selectByPrimaryKey(id);
		Role role =new Role();
		BeanUtils.copyProperties(role, sysRole);
		role.setId(id);
		Map<String ,Object> map=new HashMap<String ,Object> ();
		map.put("role_id", id);
		List<Map<String, Object>> listSysResourceByRoleId=sysRoleMapper.getResoureIdNameByRoleId(map);
		if ((listSysResourceByRoleId != null) && !listSysResourceByRoleId.isEmpty()) {
			boolean b = false;
			StringBuilder ids = new StringBuilder();
			StringBuilder names = new StringBuilder();
			for (Map<String, Object> mapIdName : listSysResourceByRoleId) {
				if (b) {
					ids.append(",");
					names.append(",");
				} else {
					b = true;
				}
				ids.append(mapIdName.get("id"));
 				names.append(mapIdName.get("name"));
			}
			role.setResourceIds(ids.toString());
			role.setResourceNames(names.toString());
		}
		//mybatis end
	//	Role r = roleService.get(id);
		request.setAttribute("role", role);
		return "/admin/roleGrant";
	}

	@RequestMapping("/grant")
	@ResponseBody
	public Json grant(Role role) {
		Json j = new Json();
		try {
			//mybatis start
			//根据id删除该角色所有权限
			//int roleId=role.getId();
			SysRoleResourceExample sysRoleResourceExample=new SysRoleResourceExample();
			sysRoleResourceExample.createCriteria().andRole_idEqualTo(role.getId());
			sysRoleResourceMapper.deleteByExample(sysRoleResourceExample);
			if ((role.getResourceIds() != null) && !role.getResourceIds().equalsIgnoreCase("")) {
				for (String id : role.getResourceIds().split(",")) {
					SysRoleResourceKey sysRoleResourceKey=new SysRoleResourceKey();
					sysRoleResourceKey.setRole_id(role.getId());
					sysRoleResourceKey.setResource_id(Integer.parseInt(id));
					sysRoleResourceMapper.insertSelective(sysRoleResourceKey);
				}
			}
			//mybatis end
			//roleService.grant(role);
			j.setMsg("授权成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

}
