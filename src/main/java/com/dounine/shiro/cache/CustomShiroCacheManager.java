package com.dounine.shiro.cache;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.util.Destroyable;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:18:30 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 自定义Shiro缓存管理 ]
 */
public class CustomShiroCacheManager implements CacheManager, Destroyable{

	private ShiroCacheManager shiroCacheManager;  
	  
    public ShiroCacheManager getShiroCacheManager() {  
        return shiroCacheManager;  
    }  
  
    public void setShiroCacheManager(ShiroCacheManager shiroCacheManager) {  
        this.shiroCacheManager = shiroCacheManager;  
    }  
  
    @Override  
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {  
        return getShiroCacheManager().getCache(name);  
    }  
  
    @Override  
    public void destroy() throws Exception {  
        shiroCacheManager.destroy();  
    }

}
