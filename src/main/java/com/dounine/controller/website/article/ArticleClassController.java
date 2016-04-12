package com.dounine.controller.website.article;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.ArticleClass;


@Controller
@RequestMapping("/admin/website/article/articleClass")
public class ArticleClassController extends BaseController<ArticleClass>{
	
	
	private static final String pathUrl = "admin/website/article/articleClass/";
	
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//内容
		
		return pathUrl+"content";
		
	}

}
