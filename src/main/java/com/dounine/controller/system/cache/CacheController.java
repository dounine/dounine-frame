package com.dounine.controller.system.cache;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin/system/cache")
public class CacheController{

	private static final String pathUrl = "admin/system/cache/";
	
	@RequestMapping(value = "operator.html", method = RequestMethod.POST)
	public String operator() {// 模块主内容

		return pathUrl + "operator";

	}

}
