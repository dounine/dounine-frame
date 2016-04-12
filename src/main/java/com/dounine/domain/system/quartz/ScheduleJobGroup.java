package com.dounine.domain.system.quartz;

import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.StatusType;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:34:59 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器分组实体类 ]
 */
public class ScheduleJobGroup extends BaseDomain {

	private static final long serialVersionUID = -7270932748325730156L;

	private Integer scheduleJobGroupId;

	private String scheduleJobGroupName;

	private String scheduleJobGroupDescription;

	public ScheduleJobGroup() {
	}

	public ScheduleJobGroup(Integer scheduleJobGroupId) {
		this.scheduleJobGroupId = scheduleJobGroupId;
	}

	public ScheduleJobGroup(Integer scheduleJobGroupId,
			StatusType status) {
		this.scheduleJobGroupId = scheduleJobGroupId;
		this.status = status;
	}

	public ScheduleJobGroup(String scheduleJobGroupName) {
		this.scheduleJobGroupName = scheduleJobGroupName;
	}

	public Integer getScheduleJobGroupId() {
		return scheduleJobGroupId;
	}

	public void setScheduleJobGroupId(Integer scheduleJobGroupId) {
		this.scheduleJobGroupId = scheduleJobGroupId;
	}

	public String getScheduleJobGroupName() {
		return scheduleJobGroupName;
	}

	public void setScheduleJobGroupName(String scheduleJobGroupName) {
		this.scheduleJobGroupName = scheduleJobGroupName;
	}

	public String getScheduleJobGroupDescription() {
		return scheduleJobGroupDescription;
	}

	public void setScheduleJobGroupDescription(
			String scheduleJobGroupDescription) {
		this.scheduleJobGroupDescription = scheduleJobGroupDescription;
	}

}
