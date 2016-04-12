package com.dounine.service.system.cache;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.dao.system.cache.FilecacheDao;
import com.dounine.domain.system.cache.Filecache;
import com.dounine.enumtype.StatusType;
import com.dounine.interceptor.PageEhCacheFilter;
import com.dounine.service.BaseService;
/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:11:39 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 文件缓存业务类 ]
 */
@Service
@Operator(name="文件缓存")
@CacheConfig(cacheNames = {"fileCache"})  
public class FilecacheService extends BaseService<Filecache>{
	
	@Autowired
	private FilecacheDao filecacheDao;

	@Override
	@Operator(story="添加文件缓存")
	@CacheEvict(allEntries=true)
	public void insert(final Filecache filecache) {
		filecache.setStatus(StatusType.NORMAL);
		filecache.setCreateTime(new Date());
		filecacheDao.insert(filecache);
		PageEhCacheFilter.init();//同步数据到过滤器
	}

	@Override
	@Operator(story="修改文件缓存")
	@CacheEvict(allEntries=true)
	public void update(Filecache filecache) {
		super.update(filecache);
		PageEhCacheFilter.init();//同步数据到过滤器
	}

	@Override
	public List<Filecache> select(Filecache filecache) {
		return super.select(filecache);
	}

	@Override
	@Operator(story="删除文件缓存")
	@CacheEvict(allEntries=true)
	public void delete(Filecache filecache) {
		filecacheDao.delete(filecache);
		PageEhCacheFilter.init();//同步数据到过滤器
	}

	@Override
	public Serializable count(Filecache filecache) {
		return super.count(filecache);
	}

	@Override
	@Operator(story="禁用文件缓存")
	@CacheEvict(allEntries=true)
	public void congeal(Filecache filecache) {
		super.congeal(filecache);
		PageEhCacheFilter.init();//同步数据到过滤器
	}

	@Override
	@Operator(story="启用文件缓存")
	@CacheEvict(allEntries=true)
	public void thaw(Filecache filecache) {
		super.thaw(filecache);
		PageEhCacheFilter.init();//同步数据到过滤器
	}
	
}
