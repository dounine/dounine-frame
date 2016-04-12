package com.dounine.domain.system.rbac;

import com.dounine.annoation.Excel;
import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:33:40 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 用户实体类 ]
 */
@Excel(fileName="用户数据")
public class User extends BaseDomain {

	private static final long serialVersionUID = -5757208275037615516L;

	@Excel(name="用户编号")
	private Integer userId;// 用户编号
	@Excel(name="用户名称")
	private String userName;// 用户名称
	private String userPassword;// 用户密码
	private Department department;// 用户所在部门
	private Integer[] userRoles;
	
	public User(){
		
	}
	
	public User(String userName){
		this.userName = userName;
	}
	
	public User(Integer userId){
		this.userId = userId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserRoles(Integer[] userRoles) {
		this.userRoles = userRoles;
	}
	

	public Integer[] getUserRoles() {
		return userRoles;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	

}
