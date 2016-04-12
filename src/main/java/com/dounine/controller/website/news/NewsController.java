package com.dounine.controller.website.news;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.news.News;

@Controller
@RequestMapping("admin/website/news/news")
public class NewsController extends BaseController<News>{
	
private static final String pathUrl = "admin/website/news/news/";
	
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//内容
		
		return pathUrl+"content";
		
	}
	@RequestMapping(value="info.html",method=RequestMethod.POST)
	public String info(){//内容
		
		return pathUrl+"info/content";
		
	}
	
}
