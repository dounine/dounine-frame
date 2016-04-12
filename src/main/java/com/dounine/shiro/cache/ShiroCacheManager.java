package com.dounine.shiro.cache;

import org.apache.shiro.cache.Cache;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:20:05 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Shiro缓存接口 ]
 */
public interface ShiroCacheManager {

	public <K, V> Cache<K, V> getCache(String name);  
	  
    public void destroy();
}
