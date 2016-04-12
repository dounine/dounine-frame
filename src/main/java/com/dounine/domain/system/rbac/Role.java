package com.dounine.domain.system.rbac;

import com.dounine.domain.TreeDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:33:09 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 角色实体类 ]
 */
public class Role extends TreeDomain<Role> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5709700061995728269L;

	private Integer roleId;
	private String roleName;
	private String roleDescription;
	private Role roleParent;
	private Integer[] rolePermissions;

	public Role() {

	}

	public Role(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public Integer[] getRolePermissions() {
		return rolePermissions;
	}

	public void setRolePermissions(Integer[] rolePermissions) {
		this.rolePermissions = rolePermissions;
	}

	public Role getRoleParent() {
		return roleParent;
	}

	public void setRoleParent(Role roleParent) {
		this.roleParent = roleParent;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

}
