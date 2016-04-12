package com.dounine.controller.system.quartz;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.quartz.ScheduleJobGroup;


@Controller
@RequestMapping("/admin/system/quartz/schedulejobgroup")
public class ScheduleJobGroupController extends BaseController<ScheduleJobGroup>{
	
	
	private static final String pathUrl = "admin/system/quartz/group/";
	
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//内容
		
		return pathUrl+"content";
		
	}

}
