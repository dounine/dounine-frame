package com.dounine.controller.system.bug;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.bug.Bug;

@Controller
@RequestMapping("admin/system/bug/bugm")
public class BugController extends BaseController<Bug> {

	private static final String pathUrl = "admin/system/bug/";

	@RequestMapping(value = "operator.html", method = RequestMethod.POST)
	public String operator() {// 控制子子功能跳转
		return pathUrl + "operator/operator";

	}

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容

		return pathUrl + "content";

	}

	@RequestMapping(value = "info.html", method = RequestMethod.POST)
	public String info() {// 模块主内容

		return pathUrl + "info/content";

	}

}
