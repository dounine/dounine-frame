package com.dounine.shiro.cache;

import org.apache.shiro.cache.Cache;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:19:41 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ JedisShiro缓存管理 ]
 */
public class JedisShiroCacheManager implements ShiroCacheManager {
	
	private JedisManager jedisManager;

	@Override
	public <K, V> Cache<K, V> getCache(String name) {
		return new JedisShiroCache<K, V>(name,jedisManager);
	}	

	@Override
	public void destroy() {
	}

	public void setJedisManager(JedisManager jedisManager) {
		this.jedisManager = jedisManager;
	}

	
}
