package com.dounine.controller;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;

import com.dounine.interceptor.OperationInterceptor;
import com.dounine.interceptor.PageEhCacheFilter;
import com.dounine.quartz.SchedulerFactory;
import com.dounine.service.system.cache.FilecacheService;
import com.dounine.service.system.log.OperationService;
import com.dounine.service.system.rbac.LoginService;
import com.dounine.service.website.ArticleService;
import com.dounine.shiro.UserMatcher;
import com.dounine.tag.ArticleAliasTag;

@Controller
public class InitServices {

	@Autowired
	private LoginService loginService;
	@Autowired
	private OperationService operationService;
	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;
	@Autowired
	private FilecacheService filecacheService;
	@Autowired
	private ArticleService articleService;
	
	@PostConstruct
	public void init(){
		SchedulerFactory.schedulerFactoryBean = this.schedulerFactoryBean;
		UserMatcher.loginService = this.loginService;
		OperationInterceptor.operationService = this.operationService;
		PageEhCacheFilter.filecacheService = this.filecacheService;
		ArticleAliasTag.articleService = this.articleService;
	}
	
}
