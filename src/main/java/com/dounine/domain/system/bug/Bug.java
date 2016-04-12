package com.dounine.domain.system.bug;

import com.dounine.domain.BaseDomain;
import com.dounine.domain.system.rbac.User;
import com.dounine.enumtype.StatusType;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.bug ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:36:01 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ BUG实体类 ]
 */
public class Bug extends BaseDomain {

	private static final long serialVersionUID = 973774631829933218L;

	private Integer bugId;// 编号
	private String bugName;// 名称
	private String bugContent;// 内容
	private BugType bugType;// bug类型
	private User user;// 创建人
	private StatusType status;// 状态

	public Integer getBugId() {
		return bugId;
	}

	public void setBugId(Integer bugId) {
		this.bugId = bugId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public StatusType getStatus() {
		return status;
	}

	public void setStatus(StatusType status) {
		this.status = status;
	}

	public String getBugName() {
		return bugName;
	}

	public void setBugName(String bugName) {
		this.bugName = bugName;
	}

	public String getBugContent() {
		return bugContent;
	}

	public void setBugContent(String bugContent) {
		this.bugContent = bugContent;
	}

	public BugType getBugType() {
		return bugType;
	}

	public void setBugType(BugType bugType) {
		this.bugType = bugType;
	}

}
