package com.dounine.controller.website.news;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.news.NewsClass;


@Controller
@RequestMapping("/admin/website/news/newsClass")
public class NewsClassController extends BaseController<NewsClass>{
	
	
	private static final String pathUrl = "admin/website/news/newsClass/";
	
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//内容
		
		return pathUrl+"content";
		
	}

}
