package com.ctl.sys.manger.model.sys;

import com.ctl.sys.manger.model.base.IdEntity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Tuser extends IdEntity implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String loginname; // 登录名
	private String password; // 密码
	private String name; // 姓名
	private Integer sex; // 性别
	private Integer age; // 年龄
	private Date createdatetime; // 创建时间
	private Integer usertype; // 用户类型
	private Integer isdefault; // 是否默认
	private Integer state; // 状态
	private String phone;
	private Torganization organization;
	private String airCompany;
	private Integer supplierguid;
	private Set<Trole> roles = new HashSet<Trole>(0);

	public Tuser() {
		super();
	}

	public Tuser(String loginname, String password, String name, Integer sex, Integer age, Date createdatetime,
			Integer usertype, Integer isdefault, Integer state) {
		super();
		this.loginname = loginname;
		this.password = password;
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.createdatetime = createdatetime;
		this.usertype = usertype;
		this.isdefault = isdefault;
		this.state = state;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Date getCreatedatetime() {
		return createdatetime;
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	public Integer getUsertype() {
		return usertype;
	}

	public void setUsertype(Integer usertype) {
		this.usertype = usertype;
	}

	public Integer getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(Integer isdefault) {
		this.isdefault = isdefault;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	public Set<Trole> getRoles() {
		return roles;
	}

	public void setRoles(Set<Trole> roles) {
		this.roles = roles;
	}
	public Torganization getOrganization() {
		return organization;
	}

	public void setOrganization(Torganization organization) {
		this.organization = organization;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAirCompany() {
		return airCompany;
	}

	public void setAirCompany(String airCompany) {
		this.airCompany = airCompany;
	}

	public Integer getSupplierguid() {
		return supplierguid;
	}

	public void setSupplierguid(Integer supplierguid) {
		this.supplierguid = supplierguid;
	}

}