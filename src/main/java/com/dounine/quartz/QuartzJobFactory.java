package com.dounine.quartz;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dounine.domain.system.quartz.ScheduleJob;


/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:09:37 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器执行类 ]
 */
@DisallowConcurrentExecution
@SuppressWarnings("all")
public class QuartzJobFactory implements Job{
	
	private static final Logger console = LoggerFactory.getLogger(QuartzJobFactory.class);
	private static Map<String, Class<?>> maps = new HashMap<String, Class<?>>();
	
	
	@Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        ScheduleJob scheduleJob = (ScheduleJob)context.getMergedJobDataMap().get("scheduleJob");
        console.info("执行任务："+scheduleJob.getScheduleJobName());
        try {
        	String className = scheduleJob.getScheduleJobClass();
        	
			Class<?> exec = null;
			if(maps.containsKey(className)){
				exec = maps.get(className);
			}else{
				ClassLoader clazz = Thread.currentThread().getContextClassLoader();
	        	if(null==clazz)clazz = QuartzJobFactory.class.getClassLoader();
				exec=clazz.loadClass(className);
				maps.put(className, exec);
			}
			try {
				Method method = exec.getMethod(scheduleJob.getScheduleJobMethod());
				method.invoke(exec.newInstance());
			} catch (NoSuchMethodException e1) {
				e1.printStackTrace();
			} catch (SecurityException e1) {
				e1.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}
