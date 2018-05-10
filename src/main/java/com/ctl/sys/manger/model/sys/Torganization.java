package com.ctl.sys.manger.model.sys;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.ctl.sys.manger.model.base.IdEntity;

public class Torganization extends IdEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date createdatetime;
	private String name;
	private String address;
	private String code;
	private String icon;
	private Integer seq;
	private Integer isdefault;
	private Torganization organization;
	private Set<Torganization> organizations = new HashSet<Torganization>(0);

	public Torganization() {
		super();
	}

	public Torganization(Date createdatetime, String name, String address, String code, String icon, Integer seq,
			Torganization organization, Set<Torganization> organizations) {
		super();
		this.createdatetime = createdatetime;
		this.name = name;
		this.address = address;
		this.code = code;
		this.icon = icon;
		this.seq = seq;
		this.organization = organization;
		this.organizations = organizations;
	}

	public Torganization getOrganization() {
		return organization;
	}

	public void setOrganization(Torganization organization) {
		this.organization = organization;
	}

	public Date getCreatedatetime() {
		return createdatetime;
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getSeq() {
		return this.seq;
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

	public Set<Torganization> getOrganizations() {
		return organizations;
	}

	public void setOrganizations(Set<Torganization> organizations) {
		this.organizations = organizations;
	}

}
