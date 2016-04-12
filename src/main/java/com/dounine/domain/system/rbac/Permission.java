package com.dounine.domain.system.rbac;

import com.dounine.domain.TreeDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:32:06 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限资源实体类 ]
 */
public class Permission extends TreeDomain<Permission> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6197680248425385299L;

	private Integer permissionId;
	private String permissionName;
	private String permissionResource;
	private String permissionDescription;
	private Permission permissionParent;
	private PermissionType permissionType;

	public Permission() {

	}

	public Permission(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public String getPermissionResource() {
		return permissionResource;
	}

	public void setPermissionResource(String permissionResource) {
		this.permissionResource = permissionResource;
	}

	public String getPermissionDescription() {
		return permissionDescription;
	}

	public void setPermissionDescription(String permissionDescription) {
		this.permissionDescription = permissionDescription;
	}

	public Permission getPermissionParent() {
		return permissionParent;
	}

	public void setPermissionParent(Permission permissionParent) {
		this.permissionParent = permissionParent;
	}

	public PermissionType getPermissionType() {
		return permissionType;
	}

	public void setPermissionType(PermissionType permissionType) {
		this.permissionType = permissionType;
	}

}
