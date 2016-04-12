package com.dounine.domain.system.rbac;

import com.dounine.domain.TreeDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:31:32 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 部门实体类 ]
 */
public class Department extends TreeDomain<Department> {

	private static final long serialVersionUID = 4172260282507327470L;
	private Integer departmentId;// 部门编号
	private String departmentName;// 部门名称
	private String departmentDescription;// 部门描述
	private Department departmentParent;// 上级部门

	public Department() {
	}

	public Department(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDepartmentDescription() {
		return departmentDescription;
	}

	public void setDepartmentDescription(String departmentDescription) {
		this.departmentDescription = departmentDescription;
	}

	public Department getDepartmentParent() {
		return departmentParent;
	}

	public void setDepartmentParent(Department departmentParent) {
		this.departmentParent = departmentParent;
	}

}
