package com.dounine.controller;

import java.util.Properties;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.domain.system.JavaInfo;
import com.dounine.finals.Finals;


@Controller
@RequestMapping("admin")
public class AdminController{

	private static final String AdminIndexUrl = "admin/index";
	private static final String AdminLoginUrl = "admin/login";
	
	@RequestMapping(value = "index.html", method = RequestMethod.GET)
	public String AdminIndex() {
		if(SecurityUtils.getSubject().isRemembered()){//记住我登录
			return AdminIndexUrl;
		}
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return AdminIndexUrl;
		}
		return AdminLoginUrl;
	}

	@RequestMapping(value = "login.html")
	public String index(HttpSession session) {
		
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return AdminIndexUrl;
		}
		return AdminLoginUrl;
	}

	@RequestMapping(value = "logout.action", method = RequestMethod.POST)
	public void logout(HttpServletResponse response) {
		Subject subject = SecurityUtils.getSubject();
		try {
			if (subject.isAuthenticated()) {
				subject.logout();
				response.getWriter().print(Finals.SUCCESS);
			} else {
				if(subject.isRemembered()){
					response.getWriter().print("login");
				}else{
					response.getWriter().print(Finals.LOGIN_AFTER_OPERATOR);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "index/index_menu.html", method = RequestMethod.POST)
	public String index_menu() {
		return "admin/index/menu";
	}
	
	@RequestMapping(value = "index/content.html", method = RequestMethod.POST)
	public String content() {
		return "admin/index/content/content";
	}
	
	@RequestMapping(value = "index/content/javainfo.action", method = RequestMethod.POST)
	@ResponseBody
	public JavaInfo javainfo(HttpServletResponse response) {
		Properties properties = System.getProperties(); //获得系统属性集 
		JavaInfo javaInfo = new JavaInfo();
		javaInfo.setVersion(properties.getProperty("java.version"));
		javaInfo.setSystem(properties.getProperty("os.name"));
		javaInfo.setDir(properties.getProperty("user.dir"));
		javaInfo.setName(properties.getProperty("java.home"));
		javaInfo.setArch(properties.getProperty("os.arch"));
		javaInfo.setProject("dounine 后台管理系统");
		return javaInfo;
	}

}
