package com.dounine.controller.system;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.dounine.domain.system.rbac.User;
import com.dounine.finals.Finals;
import com.dounine.service.system.rbac.LoginService;

@Controller
@RequestMapping("admin/index/bench")
public class BenchController {
	
	private static final String pathUrl = "admin/index/bench/";
	
	@Autowired
	private LoginService loginService;

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public ModelAndView content(ModelAndView modelAndView) {// 模块主内容
		Subject subject = SecurityUtils.getSubject(); 
		if(null!=subject){
			modelAndView.setViewName(pathUrl + "content");
			modelAndView.addObject(Finals.CURRENT_LOGIN_STRING, loginService.getLastLogin(new User(String.valueOf(subject.getPrincipals()))));//获取时间段
			return modelAndView;
		}
		return null;
	}
}
