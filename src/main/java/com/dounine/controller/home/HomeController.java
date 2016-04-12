package com.dounine.controller.home;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.domain.website.Article;
import com.dounine.domain.website.ArticleClass;
import com.dounine.domain.website.ArticleClassFinal;
import com.dounine.service.website.ArticleService;

@Controller
@RequestMapping("home")
public class HomeController {
	
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping(value="index.html",method=RequestMethod.GET)
	public String home(ModelMap map){
		map.addAttribute(ArticleClassFinal.INDEX_BOTTOM_OBJS,getIndexBottomArticles());
		return "home/index";
	}
	
	public List<Article> getIndexBottomArticles(){
		Article article = new Article();
		article.setArticleClass(new ArticleClass(ArticleClassFinal.systemArticleClassArrayValue2));
		return articleService.select(article);
	}
}
