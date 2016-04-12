package com.dounine.domain.website;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.website ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月5日 下午11:09:36 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 文章分类实体类 ]
 */
public class ArticleClass extends BaseDomain {

	private static final long serialVersionUID = -8472209693233369106L;

	private Integer id;
	private String name;
	private String description;
	
	public ArticleClass(Integer id){
		this.id = id;
	}
	
	public ArticleClass(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
