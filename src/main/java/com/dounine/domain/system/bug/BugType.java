package com.dounine.domain.system.bug;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.bug ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:36:12 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ BUG类型实体类 ]
 */
public class BugType extends BaseDomain {

	private static final long serialVersionUID = 3494611268702414167L;

	private Integer bugTypeId;
	private String bugTypeName;
	private String bugTypeDescription;

	public Integer getBugTypeId() {
		return bugTypeId;
	}

	public void setBugTypeId(Integer bugTypeId) {
		this.bugTypeId = bugTypeId;
	}

	public String getBugTypeName() {
		return bugTypeName;
	}

	public String getBugTypeDescription() {
		return bugTypeDescription;
	}

	public void setBugTypeDescription(String bugTypeDescription) {
		this.bugTypeDescription = bugTypeDescription;
	}

	public void setBugTypeName(String bugTypeName) {
		this.bugTypeName = bugTypeName;
	}

}
