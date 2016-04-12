package com.dounine.controller.website.article;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.Article;


@Controller
@RequestMapping("/admin/website/article")
public class ArticleOperatorController extends BaseController<Article>{
	
	
	private static final String pathUrl = "admin/website/article/";
	
	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){
		
		return pathUrl+"operator";
		
	}

}
