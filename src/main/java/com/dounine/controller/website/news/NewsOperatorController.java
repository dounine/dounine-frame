package com.dounine.controller.website.news;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.news.News;


@Controller
@RequestMapping("/admin/website/news")
public class NewsOperatorController extends BaseController<News>{
	
	
	private static final String pathUrl = "admin/website/news/";
	
	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){
		
		return pathUrl+"operator";
		
	}

}
