package com.dounine.quartz;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import com.dounine.domain.system.quartz.ScheduleJob;
import com.dounine.domain.system.quartz.ScheduleJobGroup;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.ScheduleException;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:09:51 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器工场类 ]
 */
public class SchedulerFactory {
	
	public static SchedulerFactoryBean schedulerFactoryBean;
	
	public static CronScheduleBuilder verifyTrigger(ScheduleJob scheduleJob){
		CronScheduleBuilder scheduleBuilder= null;
		try {
			scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getScheduleJobCronExpression());
		} catch (Exception e) {
			throw new ScheduleException("表达式不正确,请重新输入.");
		}
		return scheduleBuilder;
	}
	
	public static List<ScheduleJob> list() {
		List<ScheduleJob> jobList = new ArrayList<ScheduleJob>();
		try {
			Scheduler scheduler = schedulerFactoryBean.getScheduler();
			GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();
			Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
			for (JobKey jobKey : jobKeys) {
				List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
				for (Trigger trigger : triggers) {
					ScheduleJob scheduleJob = new ScheduleJob();
					scheduleJob.setScheduleJobId(Integer.parseInt(jobKey.getName()));
					scheduleJob.setScheduleJobGroup(new ScheduleJobGroup(jobKey.getGroup()));
					scheduleJob.setScheduleJobDescription(String.valueOf(trigger.getKey()));
					Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
					scheduleJob.setStatus(triggerState.name().equals("NORMAL")?StatusType.NORMAL:StatusType.CONGEAL);
					if (trigger instanceof CronTrigger) {
						CronTrigger cronTrigger = (CronTrigger) trigger;
						String cronExpression = cronTrigger.getCronExpression();
						scheduleJob.setScheduleJobCronExpression(cronExpression);
					}
					jobList.add(scheduleJob);
				}
			}
		} catch (Exception e) {
			throw new ScheduleException("获取失败");
		}
		return jobList;
	}
	
	public synchronized static void add(ScheduleJob scheduleJob,boolean start){
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		TriggerKey triggerKey = TriggerKey.triggerKey(String.valueOf(scheduleJob.getScheduleJobId()), String.valueOf(scheduleJob.getScheduleJobGroup().getScheduleJobGroupId()));//组合名称（定时器名称+分组名称）
		
		// 获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
		CronTrigger trigger=null;
		try {
			trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
		} catch (SchedulerException e) {
			throw new ScheduleException("表达式不正确,请重新输入.");
		}
		
		// 不存在，创建一个
		if (null == trigger) {
			JobDetail jobDetail = JobBuilder.newJob(QuartzJobFactory.class)
					.withIdentity(String.valueOf(scheduleJob.getScheduleJobId()), String.valueOf(scheduleJob.getScheduleJobGroup().getScheduleJobGroupId())).build();
			jobDetail.getJobDataMap().put("scheduleJob", scheduleJob);
			
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder= verifyTrigger(scheduleJob);
			
			// 按新的cronExpression表达式构建一个新的trigger
			trigger = TriggerBuilder.newTrigger().withIdentity(String.valueOf(scheduleJob.getScheduleJobId()), scheduleJob.getScheduleJobGroup().getScheduleJobGroupId().toString())
					.withSchedule(scheduleBuilder).build();
			
			try {
				scheduler.scheduleJob(jobDetail, trigger);
				if(!start){
					stop(scheduleJob);
				}
			} catch (SchedulerException e) {
				throw new ScheduleException(e);
			}
		} else {
			// Trigger已存在，那么更新相应的定时设置
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = verifyTrigger(scheduleJob);
			
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			
			// 按新的trigger重新设置job执行
			try {
				scheduler.rescheduleJob(triggerKey, trigger);
				if(!start){
					stop(scheduleJob);
				}
			} catch (SchedulerException e) {
				throw new ScheduleException("trigger执行失败.");
			}
		}
	}
	
	public static void stop(ScheduleJob scheduleJob) {
		try {
			Scheduler scheduler = schedulerFactoryBean.getScheduler();
			JobKey jobKey = JobKey.jobKey(String.valueOf(scheduleJob.getScheduleJobId()), String.valueOf(scheduleJob.getScheduleJobGroup().getScheduleJobGroupId()));
			scheduler.pauseJob(jobKey);
		} catch (Exception e) {
			throw new ScheduleException("定时器停止失败.");
		}
	}
	public static void reStart(ScheduleJob scheduleJob){
		try {
			Scheduler scheduler = schedulerFactoryBean.getScheduler();
			JobKey jobKey = JobKey.jobKey(String.valueOf(scheduleJob.getScheduleJobId()), String.valueOf(scheduleJob.getScheduleJobGroup().getScheduleJobGroupId()));
			scheduler.resumeJob(jobKey);
		} catch (Exception e) {
			throw new ScheduleException("定时器重启失败.");
		}
	}
	
	public static void del(ScheduleJob scheduleJob) {
		try {
			Scheduler scheduler = schedulerFactoryBean.getScheduler();
			JobKey jobKey = JobKey.jobKey(String.valueOf(scheduleJob.getScheduleJobId()), String.valueOf(scheduleJob.getScheduleJobGroup().getScheduleJobGroupId()));
			scheduler.deleteJob(jobKey);
		} catch (Exception e) {
			throw new ScheduleException("定时器删除失败.");
		}
		
	}
}
