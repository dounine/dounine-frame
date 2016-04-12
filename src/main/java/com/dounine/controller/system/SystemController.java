package com.dounine.controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin/system")
public class SystemController {

	private static final String menuUrl = "admin/system/";

	@RequestMapping(value="system_menu.html",method=RequestMethod.POST)
	public String menu(){//加载模块菜单 
		
		return menuUrl+"menu";
		
	}
}
