package com.dounine.service.system.quartz;

import java.lang.reflect.Method;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.domain.system.quartz.ScheduleJob;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.ScheduleException;
import com.dounine.quartz.SchedulerFactory;
import com.dounine.service.BaseService;
import com.dounine.utils.BeanUtil;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:13:41 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器业务类 ]
 */
@Service
@Operator(name="定时器")
public class ScheduleJobService extends BaseService<ScheduleJob> {
	
	private BeanUtil beanUtil = new BeanUtil();
	
	@Override
	@Transactional
	@Operator(story = "添加定时器")
	public void insert(ScheduleJob scheduleJob) {
		verifySchedule(scheduleJob);//验证是否通过验证
		SchedulerFactory.verifyTrigger(scheduleJob);//验证执行方法是否正确
		scheduleJob.setStatus(StatusType.CONGEAL);
		baseRepository.insert(scheduleJob);

	}

	@Override
	@Transactional
	@Operator(story = "修改定时器信息")
	public void update(ScheduleJob scheduleJob) {
		
		verifySchedule(scheduleJob);//执行方法验证是否通过验证
		SchedulerFactory.verifyTrigger(scheduleJob);//验证表达式是否正确
		List<ScheduleJob> list = (List<ScheduleJob>) super.select(scheduleJob);
		if(list.size()==0){
			throw new ScheduleException("启动错误,没有这条定时器");
		}
		baseRepository.update(scheduleJob);
		
	}

	@Override
	@Operator(story = "删除定时器信息")
	public void delete(ScheduleJob scheduleJob) {
		NotDelete.delete();
		List<ScheduleJob> list = (List<ScheduleJob>) super.select(scheduleJob);
		if(list.size()==0){
			throw new ScheduleException("启动错误,没有这条定时器");
		}
		ScheduleJob _scheduleJob = list.get(0);
		SchedulerFactory.del(_scheduleJob);//删除定时器
		baseRepository.delete(_scheduleJob);
		
	}
	

	@Override
	@Transactional
	@Operator(story = "停止定时器")
	public void congeal(ScheduleJob scheduleJob) {
		scheduleJob.setStatus(null);
		List<ScheduleJob> list = (List<ScheduleJob>) super.select(scheduleJob);
		if(list.size()==0){
			throw new ScheduleException("停止错误,没有这条定时器");
		}
		ScheduleJob _scheduleJob = list.get(0);
		if(_scheduleJob.getScheduleJobGroup().getStatus()==StatusType.CONGEAL){
			throw new ScheduleException("停止失败,请对所在定时器类型进行解冻操作.");
		}
		verifySchedule(_scheduleJob);//执行方法验证是否通过验证
		SchedulerFactory.stop(_scheduleJob);//在队列中停止
		_scheduleJob.setStatus(StatusType.CONGEAL);
		super.congeal(_scheduleJob);
		
	}

	@Override
	@Transactional
	@Operator(story = "启动定时器")
	public void thaw(ScheduleJob scheduleJob) {
		scheduleJob.setStatus(null);
		List<ScheduleJob> list = (List<ScheduleJob>) super.select(scheduleJob);
		if(list.size()==0){
			throw new ScheduleException("启动错误,没有这条定时器");
		}
		ScheduleJob _scheduleJob = list.get(0);
		verifySchedule(_scheduleJob);//执行方法验证是否通过验证
		SchedulerFactory.verifyTrigger(_scheduleJob);//验证表达式是否正确
		if(_scheduleJob.getScheduleJobGroup().getStatus()==StatusType.CONGEAL){
			throw new ScheduleException("启动失败,请对所在定时器类型进行解冻操作.");
		}
		SchedulerFactory.add(_scheduleJob,true);//添加到执行队列中
		_scheduleJob.setStatus(StatusType.NORMAL);
		baseRepository.thaw(_scheduleJob);
		
	}

	@Transactional
	@Operator(story = "重启定时器")
	public void restart(Integer scheduleJobId) {
		List<ScheduleJob> list = (List<ScheduleJob>) super.select(new ScheduleJob(scheduleJobId));
		if(list.size()==0){
			throw new ScheduleException("重启错误,没有这条定时器");
		}
		ScheduleJob scheduleJob = list.get(0);
		if(scheduleJob.getScheduleJobGroup().getStatus()==StatusType.CONGEAL){
			throw new ScheduleException("重启失败,请对所在定时器类型进行解冻操作.");
		}
		verifySchedule(scheduleJob);//执行方法验证是否通过验证
		SchedulerFactory.verifyTrigger(scheduleJob);//验证表达式是否正确
		SchedulerFactory.reStart(scheduleJob);//重启定时器
		scheduleJob.setStatus(StatusType.NORMAL);//修改为运行中
		baseRepository.thaw(scheduleJob);
		
	}
	
	public void verifySchedule(ScheduleJob scheduleJob){
		Class<?> class1 = beanUtil.classExists(scheduleJob.getScheduleJobClass());
		if(class1!=null){
			Method method = null;
			if(null!=(method=beanUtil.methodExists(class1,scheduleJob.getScheduleJobMethod()))){
				if(!beanUtil.parameterTypesExists(method)){
					throw new ScheduleException("执行方法中不能存有任何参数.");
				}
			}else{
				throw new ScheduleException("执行方法不存在此调用类中.");
			}
		}else{
			throw new ScheduleException("调用类不存在此系统中.");
		}
	}

	@Transactional
	@Operator(story = "同步定时器")
	public void async() {
		List<ScheduleJob> remoteList = (List<ScheduleJob>) super.select(new ScheduleJob());
		for(ScheduleJob scheduleJob : remoteList){
			verifySchedule(scheduleJob);//执行方法验证是否通过验证
			SchedulerFactory.verifyTrigger(scheduleJob);//验证表达式是否正确
			if(scheduleJob.getStatus()==StatusType.CONGEAL){
				SchedulerFactory.add(scheduleJob,false);//添加到执行队列中
			}else if(scheduleJob.getStatus()==StatusType.NORMAL){
				SchedulerFactory.add(scheduleJob,true);//添加到执行队列中
			}
		}
	}

	public boolean ckAsync() {
		ScheduleJob scheduleJob = new ScheduleJob();
		scheduleJob.setRows(Integer.valueOf(String.valueOf(count(new ScheduleJob()))));
		List<ScheduleJob> remoteList = (List<ScheduleJob>) super.select(scheduleJob);
		List<ScheduleJob> localList = SchedulerFactory.list();
		if(remoteList.size()!=localList.size()){
			return false;
		}else{
			for(int i =0;i<remoteList.size();i++){
				ScheduleJob remoteSch = remoteList.get(i);
				ScheduleJob localSch = localList.get(i);
				if(remoteSch.getStatus()!=localSch.getStatus()){
					return false;
				}
			}
		}
		return true;
	}

}
