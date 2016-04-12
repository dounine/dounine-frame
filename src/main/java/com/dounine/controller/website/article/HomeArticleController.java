package com.dounine.controller.website.article;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.domain.website.Article;
import com.dounine.service.website.ArticleService;

@Controller
public class HomeArticleController {
	
	@Autowired
	private ArticleService articleService;

	@RequestMapping(value="article/read/{id}.html",method=RequestMethod.GET)
	public void read(@PathVariable Integer id,HttpServletResponse response){//阅读文章
		try {
			Article article = articleService.find(new Article(id));
			if(null!=article){
				if(null!=article.getAlias()&&!article.getAlias().equals("")){
					response.sendRedirect("/article/"+article.getAlias()+".html");
				}else{
					response.sendRedirect(id+".html");
				}
			}else{
				response.sendRedirect("/error.html");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="article/{url}.html",method=RequestMethod.GET)
	public String about(@PathVariable String url,ModelMap map){//重定向到标记文章
		Article article = null;
		if(url.matches("[0-9]+")){
			article = articleService.find(new Article(Integer.parseInt(url)));
		}else{
			article = articleService.find(new Article(url));
		}
		if(null!=article){
			map.addAttribute("article", article);
		}
		return "home/article/sysview";
	}
}
