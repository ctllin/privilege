package com.ctl.sys.manger.model.sys;

import java.util.HashSet;
import java.util.Set;


import com.ctl.sys.manger.model.base.IdEntity;
public class Trole extends IdEntity implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name; // 角色名称
	private Integer seq; // 排序号
	private Integer isdefault; // 是否默认
	private String description; // 备注
	private Set<Tresource> resources = new HashSet<Tresource>(0);
	private Set<Tuser> users = new HashSet<Tuser>(0);

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(Integer isdefault) {
		this.isdefault = isdefault;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<Tresource> getResources() {
		return resources;
	}

	public void setResources(Set<Tresource> resources) {
		this.resources = resources;
	}

	public Set<Tuser> getUsers() {
		return users;
	}

	public void setUsers(Set<Tuser> users) {
		this.users = users;
	}

}
