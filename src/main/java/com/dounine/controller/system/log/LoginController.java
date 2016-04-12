package com.dounine.controller.system.log;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.Login;

@Controller
@RequestMapping("admin/system/log/login")
public class LoginController extends BaseController<Login>{
	
	private static final String pathUrl = "admin/system/log/login/";
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}
}
