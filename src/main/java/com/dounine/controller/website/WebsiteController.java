package com.dounine.controller.website;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin/website")
public class WebsiteController {
	
	private static final String pathUrl = "admin/website/";

	@RequestMapping(value="website_menu.html",method=RequestMethod.POST)
	public String menu(){//加载模块菜单 
		
		return pathUrl+"menu";
		
	}
	
}
