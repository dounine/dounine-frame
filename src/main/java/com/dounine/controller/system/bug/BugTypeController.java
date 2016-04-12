package com.dounine.controller.system.bug;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.bug.BugType;

@Controller
@RequestMapping("admin/system/bug/bugType")
public class BugTypeController extends BaseController<BugType> {

	private static final String pathUrl = "admin/system/bug/type/";

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容

		return pathUrl + "content";

	}

}
