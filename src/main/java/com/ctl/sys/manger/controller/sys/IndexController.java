package com.ctl.sys.manger.controller.sys;

import java.util.List;
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
import com.ctl.sys.manger.mapper.SysUserMapper;
import com.ctl.sys.manger.mapper.SysUserRoleMapper;
import com.ctl.sys.manger.pageModel.base.Json;
import com.ctl.sys.manger.pageModel.base.SessionInfo;
import com.ctl.sys.manger.pageModel.sys.User;
import com.ctl.sys.manger.po.SysUser;
import com.ctl.sys.manger.po.SysUserExample;
import com.ctl.sys.manger.utils.MD5Util;
@Controller
@RequestMapping("/admin")
public class IndexController extends BaseController {

//	@Autowired
//	private UserServiceI userService;

//	@Autowired
//	private ResourceServiceI resourceService;
	@Autowired
	private SysUserMapper sysUserMapper;
	@Autowired
	private SysResourceMapper sysResourceMapper;
	@Autowired
	private SysUserRoleMapper sysUserRoleMapper;
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		if ((sessionInfo != null) && (sessionInfo.getId() != null)) {
			return "/index";
		}
		return "/login";
	}

	@ResponseBody
	@RequestMapping("/login")
	public Json login(User user, HttpSession session) {
		Json j = new Json();
		User sysuser = getUser(user);//userService.login(user);
		if (sysuser != null) {
			j.setSuccess(true);
			j.setMsg("登陆成功！");

			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setId(sysuser.getId());
			sessionInfo.setLoginname(sysuser.getLoginname());
			sessionInfo.setName(sysuser.getName());
			sessionInfo.setAirCompany(sysuser.getAirCompany());
			sessionInfo.setSupplier_id(sysuser.getSupplier_id());
			// user.setIp(IpUtil.getIpAddr(getRequest()));
			//sessionInfo.setResourceList(userService.listResource(sysuser.getId()));
			//sessionInfo.setResourceAllList(resourceService.listAllResource());
			sessionInfo.setResourceList(listResource(sysuser.getId()));//mybatis
			sessionInfo.setResourceAllList(listAllResource());//mybatis
			session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);
		} else {
			j.setMsg("用户名或密码错误！");
		}
		return j;
	}

	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session) {
		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
		j.setSuccess(true);
		j.setMsg("注销成功！");
		return j;
	}
	//根据user id 获取权限
	public List<String> listResource(Integer id) {
			return sysUserMapper.selectUrl(id);
	}
	
		//获取用户是否存在
	public User getUser(User user) {
		SysUserExample sysUserExample=new SysUserExample();
		//state 0启用 1 停用  停用用户不能登录
		sysUserExample.createCriteria().andLoginnameEqualTo(user.getLoginname()).andPasswordEqualTo(MD5Util.md5(user.getPassword())).andStateEqualTo(0);
		List<SysUser> selectByExample = sysUserMapper.selectByExample(sysUserExample);
		if(selectByExample!=null&&selectByExample.size()>=1){
			BeanUtils.copyProperties(selectByExample.get(0), user);
			user.setId(selectByExample.get(0).getId());//short无法直接转long
			user.setOrganizationId(selectByExample.get(0).getOrganization_id());//short无法直接转long
			return user;
		}
		return null;
	}
	//获取所有的权限
	public List<String> listAllResource() {
			return sysResourceMapper.selectUrl();
	}
}
