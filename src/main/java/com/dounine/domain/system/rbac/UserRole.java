package com.dounine.domain.system.rbac;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:34:37 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 用户角色实体类 ]
 */
public class UserRole extends BaseDomain {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7934824445736613634L;

	private Integer userId;
	private Integer roleId;
	
	public UserRole(){
		
	}
	
	public UserRole(Integer userId,Integer roleId){
		this.userId = userId;
		this.roleId = roleId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

}
