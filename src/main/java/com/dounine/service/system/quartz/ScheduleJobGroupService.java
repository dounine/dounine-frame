package com.dounine.service.system.quartz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.dao.BaseRepository;
import com.dounine.domain.system.quartz.ScheduleJob;
import com.dounine.domain.system.quartz.ScheduleJobGroup;
import com.dounine.enumtype.StatusType;
import com.dounine.quartz.SchedulerFactory;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.quartz ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:12:25 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 定时器分组业务类 ]
 */
@Service
@Operator(name="定时器分组")
public class ScheduleJobGroupService extends BaseService<ScheduleJobGroup> {
	
	@Autowired
	protected BaseRepository<ScheduleJob> scheduleJobDao;


	@Override
	@Transactional
	@Operator(story="冻结定时器分组")
	public void congeal(ScheduleJobGroup scheduleJobGroup) {
		ScheduleJob scheduleJob = new ScheduleJob();
		scheduleJob.setScheduleJobGroup(scheduleJobGroup);
		List<ScheduleJob> list = (List<ScheduleJob>) scheduleJobDao.select(scheduleJob);
		for(ScheduleJob scheduleJob2 : list){//把定时器分组下的所有定时器都停止掉
			SchedulerFactory.stop(scheduleJob2);
			scheduleJob2.setStatus(StatusType.CONGEAL);
			scheduleJobDao.congeal(scheduleJob2);
		}
		scheduleJobGroup.setStatus(StatusType.CONGEAL);//冻结
		baseRepository.congeal(scheduleJobGroup);
	}
	
}
