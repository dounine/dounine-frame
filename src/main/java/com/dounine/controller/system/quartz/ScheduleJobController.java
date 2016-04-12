package com.dounine.controller.system.quartz;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.quartz.ScheduleJob;
import com.dounine.service.system.quartz.ScheduleJobService;


@Controller
@RequestMapping("/admin/system/quartz/schedulejob")
public class ScheduleJobController extends BaseController<ScheduleJob>{
	
	@Autowired
	private ScheduleJobService scheduleJobService;
	
	private static final String pathUrl = "admin/system/quartz/";
	
	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){//模块主内容
		
		return pathUrl+"operator";
		
	}
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}
	
	@RequestMapping(value="restart.action",method=RequestMethod.POST)
	public void restart(Integer scheduleJobId,HttpServletResponse response){//重启
		
		scheduleJobService.restart(scheduleJobId);
		
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="async.action",method=RequestMethod.POST)
	public void async(HttpServletResponse response){//同步定时器
		
		scheduleJobService.async();
		
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="ckasync.action",method=RequestMethod.POST)
	public void ckasync(HttpServletResponse response){//检查是否同步
		
		if(!scheduleJobService.ckAsync()){
			try {
				response.getWriter().print(FAILURE);
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
