package com.dounine.domain.system.quartz;

import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.StatusType;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:35:15 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器实体类 ]
 */
public class ScheduleJob extends BaseDomain {

	private static final long serialVersionUID = -7270932748325730156L;

	/** 任务id */
	private Integer scheduleJobId;

	/** 任务名称 */
	private String scheduleJobName;

	/** 任务分组 */
	private ScheduleJobGroup scheduleJobGroup;

	/** 任务运行时间表达式 */
	private String scheduleJobCronExpression;

	/** 任务描述 */
	private String scheduleJobDescription;

	private String scheduleJobClass;

	private String scheduleJobMethod;

	public ScheduleJob() {

	}
	
	public ScheduleJob(Integer scheduleJobId) {
		this.scheduleJobId = scheduleJobId;
	}

	public ScheduleJob(Integer scheduleJobId, StatusType status) {
		this.scheduleJobId = scheduleJobId;
		super.status = status;
	}

	public Integer getScheduleJobId() {
		return scheduleJobId;
	}

	public void setScheduleJobId(Integer scheduleJobId) {
		this.scheduleJobId = scheduleJobId;
	}

	public String getScheduleJobName() {
		return scheduleJobName;
	}

	public void setScheduleJobName(String scheduleJobName) {
		this.scheduleJobName = scheduleJobName;
	}

	public ScheduleJobGroup getScheduleJobGroup() {
		return scheduleJobGroup;
	}

	public void setScheduleJobGroup(ScheduleJobGroup scheduleJobGroup) {
		this.scheduleJobGroup = scheduleJobGroup;
	}

	public String getScheduleJobMethod() {
		return scheduleJobMethod;
	}

	public void setScheduleJobMethod(String scheduleJobMethod) {
		this.scheduleJobMethod = scheduleJobMethod;
	}

	public StatusType getStatus() {
		return status;
	}

	public void setStatus(StatusType status) {
		this.status = status;
	}

	public String getScheduleJobCronExpression() {
		return scheduleJobCronExpression;
	}

	public void setScheduleJobCronExpression(String scheduleJobCronExpression) {
		this.scheduleJobCronExpression = scheduleJobCronExpression;
	}

	public String getScheduleJobDescription() {
		return scheduleJobDescription;
	}

	public String getScheduleJobClass() {
		return scheduleJobClass;
	}

	public void setScheduleJobClass(String scheduleJobClass) {
		this.scheduleJobClass = scheduleJobClass;
	}

	public void setScheduleJobDescription(String scheduleJobDescription) {
		this.scheduleJobDescription = scheduleJobDescription;
	}

}
