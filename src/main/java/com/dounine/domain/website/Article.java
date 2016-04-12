package com.dounine.domain.website;

import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.StatusType;

/**
 * @ProjectName: [ 逗你呢框架管理系统 ]
 * @Package: [ com.dounine.domain.website ]
 * @Author: [ huanghuanlai ]
 * @CreateTime: [ 2015年2月5日 下午11:09:24 ]
 * @Copy: [ dounine.com ]
 * @Version: [ v1.0 ]
 * @Description: [ 文章实体类 ]
 */
public class Article extends BaseDomain {

	private static final long serialVersionUID = 5825737297936834565L;

	private Integer id;
	private String keywords;
	private String description;
	private String title;
	private String content;
	private String alias;
	private ArticleClass articleClass;
	private Integer articleClassId;

	public Article() {

	}

	public String getKeywords() {
		return keywords;
	}

	public Integer getArticleClassId() {
		return articleClassId;
	}

	public void setArticleClassId(Integer articleClassId) {
		this.articleClassId = articleClassId;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Article(String alias) {
		this.alias = alias;
	}

	public Article(Integer id) {
		this.id = id;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ArticleClass getArticleClass() {
		return articleClass;
	}

	public void setArticleClass(ArticleClass articleClass) {
		this.articleClass = articleClass;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public StatusType getStatus() {
		return status;
	}

	public void setStatus(StatusType status) {
		this.status = status;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
