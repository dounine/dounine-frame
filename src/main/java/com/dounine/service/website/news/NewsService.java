package com.dounine.service.website.news;

import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.domain.website.news.News;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.website ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月5日 下午11:33:16 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 文章业务类 ]
 */
@Service
@Operator(name="新闻")
public class NewsService extends BaseService<News> {

	@Override
	public void insert(News t) {
		t.setHits(0);//点击量
		super.insert(t);
	}
	
	
}
