package com.dounine.domain.system.rbac;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:33:25 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 角色权限实体类 ]
 */
public class RolePermission extends BaseDomain {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1663399369658149030L;

	private Integer roleId;
	private Integer permissionId;
	
	public RolePermission(){
		
	}
	
	public RolePermission(Integer roleId,Integer permissionId){
		this.roleId = roleId;
		this.permissionId = permissionId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

}
