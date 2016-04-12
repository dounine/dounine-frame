package com.dounine.controller.system.cache;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.cache.Filecache;

@Controller
@RequestMapping("admin/system/cache/filecache")
public class FilecacheController extends BaseController<Filecache>{

	private static final String pathUrl = "admin/system/cache/filecache/";

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容

		return pathUrl + "content";

	}
}
