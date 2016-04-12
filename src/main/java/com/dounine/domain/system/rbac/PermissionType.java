package com.dounine.domain.system.rbac;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:32:46 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限资源类型实体类 ]
 */
public class PermissionType extends BaseDomain {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2473912364480466793L;

	private Integer permissionTypeId;
	private String permissionTypeName;
	private String permissionTypeDescription;

	public Integer getPermissionTypeId() {
		return permissionTypeId;
	}

	public void setPermissionTypeId(Integer permissionTypeId) {
		this.permissionTypeId = permissionTypeId;
	}

	public String getPermissionTypeName() {
		return permissionTypeName;
	}

	public void setPermissionTypeName(String permissionTypeName) {
		this.permissionTypeName = permissionTypeName;
	}

	public String getPermissionTypeDescription() {
		return permissionTypeDescription;
	}

	public void setPermissionTypeDescription(String permissionTypeDescription) {
		this.permissionTypeDescription = permissionTypeDescription;
	}

}
