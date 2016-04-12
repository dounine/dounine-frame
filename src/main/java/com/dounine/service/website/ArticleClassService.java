package com.dounine.service.website;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.domain.website.ArticleClass;
import com.dounine.domain.website.ArticleClassFinal;
import com.dounine.exception.CustomException;
import com.dounine.finals.NoDeleteIds;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.website ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月5日 下午11:32:47 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 文章分类业务类 ]
 */
@Service
@Operator(name="文章分类")
public class ArticleClassService extends BaseService<ArticleClass> {

	@Override
	@Transactional
	public void delete(ArticleClass t) {
		if(NoDeleteIds.PassInt(ArticleClassFinal.systemArticleClassArray,t.getId())){
			throw new CustomException(NoDeleteIds.TIP_TEXT);
		}
		super.delete(t);
	}
	
	
	
}
