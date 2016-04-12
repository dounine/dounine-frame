package com.dounine.controller.system.bug;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin/system/bug")
public class BugOperatorController {

	private static final String pathUrl = "admin/system/bug/";

	@RequestMapping(value = "operator.html", method = RequestMethod.POST)
	public String operator() {// 控制子功能跳转

		return pathUrl + "operator";

	}
}
