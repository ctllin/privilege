package com.ctl.sys.manger.controller.sys;

import java.util.Date;
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
import com.ctl.sys.manger.framework.constant.GlobalConstant;
import com.ctl.sys.manger.mapper.SysOrganizationMapper;
import com.ctl.sys.manger.mapper.SysUserMapper;
import com.ctl.sys.manger.mapper.SysUserRoleMapper;
import com.ctl.sys.manger.model.sys.Trole;
import com.ctl.sys.manger.model.sys.Tuser;
import com.ctl.sys.manger.pageModel.base.Grid;
import com.ctl.sys.manger.pageModel.base.Json;
import com.ctl.sys.manger.pageModel.base.SessionInfo;
import com.ctl.sys.manger.pageModel.sys.User;
import com.ctl.sys.manger.po.SysOrganization;
import com.ctl.sys.manger.po.SysUser;
import com.ctl.sys.manger.po.SysUserExample;
import com.ctl.sys.manger.po.SysUserRoleExample;
import com.ctl.sys.manger.po.SysUserRoleKey;
import com.ctl.sys.manger.service.base.ServiceException;
import com.ctl.sys.manger.utils.MD5Util;
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

// 	@Autowired
// 	private UserServiceI userService;
	
	@Autowired
	private SysUserRoleMapper sysUserRoleMapper;
	
	@Autowired
	private SysUserMapper sysUserMapper;
	
	@Autowired
	private SysOrganizationMapper sysOrganizationMapper;
	
	@RequestMapping("/manager")
	public String manager() {
		return "/admin/user";
	}

	@RequestMapping("/dataGrid")
	@ResponseBody
	public Grid dataGrid(User user) {
		Grid grid = new Grid();
		//mybatis start
		SysUserExample	sysUserExample =new SysUserExample();
		com.ctl.sys.manger.po.SysUserExample.Criteria criteria=sysUserExample.createCriteria();
		if(user.getName()!=null&&!"".equals(user.getName().trim())){
			criteria.andNameLike("%"+user.getName()+"%");
		}
		if(user.getOrganizationId()!=null&&!"".equals(user.getOrganizationId())){
			criteria.andOrganization_idEqualTo(user.getOrganizationId());
		}
		if(user.getAirCompany()!=null&&!"".equals(user.getAirCompany().trim())){
			criteria.andAirCompanyEqualTo(user.getAirCompany());
		}
		if(user.getSupplier_id()!=null&&!"".equals(user.getSupplier_id())){
			criteria.andSupplier_idEqualTo(user.getSupplier_id());
		}
		long totalRow = sysUserMapper.countByExample(sysUserExample);
		List<SysUser> dataList = sysUserMapper.selectByExample(sysUserExample);
	    grid.setRows(dataList);
		grid.setTotal(totalRow);
		//mybatis end
 		//grid.setRows(userService.dataGrid(user, ph));
 		//grid.setTotal(userService.count(user, ph));
		return grid;
	}

	@RequestMapping("/editPwdPage")
	public String editPwdPage() {
		return "/admin/userEditPwd";
	}

	@RequestMapping("/editUserPwd")
	@ResponseBody
	public Json editUserPwd(HttpServletRequest request, String oldPwd, String pwd) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		Json j = new Json();
		try {
			//mybatis start
			 SysUser selectByPrimaryKey = sysUserMapper.selectByPrimaryKey(sessionInfo.getId());
			 if (selectByPrimaryKey.getPassword().equalsIgnoreCase(MD5Util.md5(oldPwd))) {// 说明原密码输入正确
				 selectByPrimaryKey.setPassword(MD5Util.md5(pwd));
				 sysUserMapper.updateByPrimaryKeySelective(selectByPrimaryKey);
			  }else{
				    j.setSuccess(false);
					j.setMsg("原密码输入错误，密码修改失败！");
					return j;
			  }
			 //mybatis end
			//userService.editUserPwd(sessionInfo, oldPwd, pwd);
			j.setSuccess(true);
			j.setMsg("密码修改成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/addPage")
	public String addPage() {
		return "/admin/userAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(User user) {
		Json j = new Json();
		//mybatis start
		SysUser sysUser=new SysUser();
		BeanUtils.copyProperties(user, sysUser);
		sysUser.setOrganization_id(user.getOrganizationId());
		SysUserExample	sysUserExample =new SysUserExample();
		com.ctl.sys.manger.po.SysUserExample.Criteria criteria=sysUserExample.createCriteria();
		if(user.getLoginname()!=null&&!"".equals(user.getLoginname().trim())){
			criteria.andLoginnameEqualTo(user.getLoginname());
		}
		long totalRow = sysUserMapper.countByExample(sysUserExample);
		//mybatis end
		//User u = userService.getByLoginName(user);
		if (totalRow>0) {
			j.setMsg("用户名已存在!");
		} else {
			try {
				//mybatis start
				sysUser.setPassword(MD5Util.md5(sysUser.getPassword()));
				sysUser.setState(GlobalConstant.ENABLE);
				sysUser.setIsdefault(1);//1是非默认可以删除,0用户不可以删除
				sysUser.setCreatedatetime(new Date());
				sysUserMapper.insert(sysUser);
				for (String roleId : user.getRoleIds().split(",")) {
					SysUserRoleKey sysUserRole=new SysUserRoleKey();
					sysUserRole.setRole_id(Integer.parseInt(roleId.toString()));
					sysUserRole.setUser_id(sysUser.getId());
					sysUserRoleMapper.insert(sysUserRole);
				}
				//mybatis end
				
				//user.setIsdefault(1);//1是非默认可以删除,0用户不可以删除
				//userService.add(user);
				j.setSuccess(true);
				j.setMsg("添加成功！");
			} catch (Exception e) {
				j.setMsg(e.getMessage());
			}

		}
		return j;
	}

	@RequestMapping("/get")
	@ResponseBody
	public User get(Long id) {
		//mybatis start
		Map<String,Object>  map=new HashMap<String,Object>();
		map.put("userId", id);
		Tuser user=sysUserMapper.selectUserUserroleRole(map);
		User u = new User();
		BeanUtils.copyProperties(user, u);

		if (user.getOrganization() != null) {
			u.setOrganizationId(user.getOrganization().getId());
			u.setOrganizationName(user.getOrganization().getName());
		}

		if ((user.getRoles() != null) && !user.getRoles().isEmpty()) {
			String roleIds = "";
			String roleNames = "";
			boolean b = false;
			for (Trole role : user.getRoles()) {
				if (b) {
					roleIds += ",";
					roleNames += ",";
				} else {
					b = true;
				}
				roleIds += role.getId();
				roleNames += role.getName();
			}
			u.setRoleIds(roleIds);
			u.setRoleNames(roleNames);
		}
		return u;
		//mybatis end
		//return userService.get(id);
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		Json j = new Json();
		try {
			//mybatis start
			sysUserMapper.deleteByPrimaryKey(id);
			SysUserRoleExample	sysUserRoleExample =new SysUserRoleExample();
			sysUserRoleExample.createCriteria().andUser_idEqualTo(id);
			//删除用户对应的角色
			sysUserRoleMapper.deleteByExample(sysUserRoleExample);
			//mybatis end
			//userService.delete(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Integer id) {
		
		//mybatis start
		SysUser sysUser=sysUserMapper.selectByPrimaryKey(id);
		User user=new User();
		BeanUtils.copyProperties(sysUser, user);
		SysUserRoleExample	sysUserRoleExample =new SysUserRoleExample();
		sysUserRoleExample.createCriteria().andUser_idEqualTo(id);
		List<SysUserRoleKey> sysUserRoleList = sysUserRoleMapper.selectByExample(sysUserRoleExample);
		SysOrganization sysOrganization=sysOrganizationMapper.selectByPrimaryKey(sysUser.getOrganization_id());
		user.setOrganizationId(sysOrganization.getId());
		user.setOrganizationName(sysOrganization.getName());
		boolean b = false;
		StringBuilder ids = new StringBuilder();
		StringBuilder names = new StringBuilder();
		for (SysUserRoleKey sysUserRoleKey: sysUserRoleList) {
			if (b) {
				ids.append(",");
				names.append(",");
			} else {
				b = true;
			}
			ids.append(sysUserRoleKey.getRole_id());
			//names += sysUserRoleKey.getName();
		}
		user.setRoleIds(ids.toString());
		//user.setRoleNames(names.toString());
		//mybatis end
		
		
		request.setAttribute("user", user);
		//User u = userService.get(id);
		//request.setAttribute("user", u);
		return "/admin/userEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(User user) {
		Json j = new Json();
		try {
			//mybatis start
			SysUser sysUser=new SysUser();
			BeanUtils.copyProperties(user, sysUser);
			if(sysUser.getPassword()!=null&&!"".equals(sysUser.getPassword())){
				sysUser.setPassword(MD5Util.md5(sysUser.getPassword()));
			}
			//sysUser.setId(Integer.parseInt(user.getId().toString()));
			sysUser.setOrganization_id(user.getOrganizationId());
			SysUserRoleExample	sysUserRoleExample =new SysUserRoleExample();
			sysUserRoleExample.createCriteria().andUser_idEqualTo(user.getId());
			sysUserRoleMapper.deleteByExample(sysUserRoleExample);
			String roleIds[]=user.getRoleIds().split(",");
			for(String roleId:roleIds){
				SysUserRoleKey sysUserRole=new SysUserRoleKey();
				sysUserRole.setRole_id(Integer.parseInt(roleId));
				sysUserRole.setUser_id(user.getId());
				sysUserRoleMapper.insert(sysUserRole);
			}
			//mybatis end
			sysUserMapper.updateByPrimaryKeySelective(sysUser);
			//userService.edit(user);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (ServiceException e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

}
