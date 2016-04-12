package com.dounine.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.csrf.tag.AbstractUriTag;
import com.dounine.domain.website.Article;
import com.dounine.service.website.ArticleService;

public class ArticleAliasTag extends AbstractUriTag{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5448490707745935549L;
	
	@Autowired
	public static ArticleService articleService;
	
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
	@Override
	public int doStartTag() throws JspException {
		try {
			Article article = articleService.find(new Article(Integer.parseInt(id)));
			String aliasString = null;
			if(null!=article.getAlias()&&!article.getAlias().equals("")){
				aliasString = article.getAlias();
			}else{
				aliasString = id;
			}
			pageContext.getOut().write(new StringBuffer().append("article/").append(aliasString).append(".html").toString());
		} catch (IOException e) {
			pageContext.getServletContext().log(e.getLocalizedMessage(), e);
		}
		
		return SKIP_BODY;
		
	}
}
