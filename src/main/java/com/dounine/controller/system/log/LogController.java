package com.dounine.controller.system.log;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.log.Operation;

@Controller
@RequestMapping("admin/system/log")
public class LogController extends BaseController<Operation>{
	
	private static final String menuUrl = "admin/system/log/";

	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){//控制子功能跳转
		
		return menuUrl+"operator";
		
	}
	
}
