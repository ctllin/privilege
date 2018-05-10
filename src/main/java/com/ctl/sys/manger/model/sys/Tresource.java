package com.ctl.sys.manger.model.sys;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.ctl.sys.manger.model.base.IdEntity;

public class Tresource extends IdEntity implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date createdatetime; // 创建时间
	private String name; // 名称
	private String url; // 菜单路径
	private String description; // 描述
	private String icon; // 图标
	private Integer seq; // 排序号
	private Integer resourcetype; // 资源类型, 0菜单 1功能
	private Tresource resource; // 父级
	private Integer state; // 状态 0启用 1停用
	private Integer isdefault;//1非默认资源可以删除，0默认资源不可以删除
	private Set<Trole> roles = new HashSet<Trole>(0);
	private Set<Tresource> resources = new HashSet<Tresource>(0);

	public Tresource() {
	}

	public Tresource(Integer id, Date createdatetime, String name, String url, String description, String icon,
			Integer seq, Integer resourcetype, Tresource resource, Integer state) {
		super();
		this.id = id;
		this.createdatetime = createdatetime;
		this.name = name;
		this.url = url;
		this.description = description;
		this.icon = icon;
		this.seq = seq;
		this.resourcetype = resourcetype;
		this.resource = resource;
		this.state = state;
	}

	public Date getCreatedatetime() {
		return createdatetime;
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getResourcetype() {
		return resourcetype;
	}

	public void setResourcetype(Integer resourcetype) {
		this.resourcetype = resourcetype;
	}

	public Tresource getResource() {
		return resource;
	}

	public void setResource(Tresource resource) {
		this.resource = resource;
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

	public Set<Tresource> getResources() {
		return resources;
	}

	public void setResources(Set<Tresource> resources) {
		this.resources = resources;
	}

	public Integer getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(Integer isdefault) {
		this.isdefault = isdefault;
	}

}