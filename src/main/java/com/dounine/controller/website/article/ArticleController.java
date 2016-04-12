package com.dounine.controller.website.article;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.Article;


@Controller
@RequestMapping("/admin/website/article/article")
public class ArticleController extends BaseController<Article>{
	
	
	private static final String pathUrl = "admin/website/article/article/";
	
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//内容
		
		return pathUrl+"content";
		
	}
	@RequestMapping(value="info.html",method=RequestMethod.POST)
	public String info(){//内容
		
		return pathUrl+"info/content";
		
	}
	
}
