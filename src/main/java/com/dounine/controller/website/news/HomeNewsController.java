package com.dounine.controller.website.news;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeNewsController {

	@RequestMapping(value="news.html",method=RequestMethod.GET)
	public String news(){
		return "home/news/index";
	}
	
	@RequestMapping(value="news/view.html",method=RequestMethod.GET)
	public String newsView(){
		return "home/news/view";
	}
	
	@RequestMapping(value="news/list.html",method=RequestMethod.GET)
	public String newsList(){
		return "home/news/list";
	}
}
