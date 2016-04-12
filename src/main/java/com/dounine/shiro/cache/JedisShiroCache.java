package com.dounine.shiro.cache;

import java.util.Collection;
import java.util.Set;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:19:15 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ JedisShiro缓存 ]
 */
public class JedisShiroCache<K, V> implements Cache<K, V> {

    private static final String REDIS_SHIRO_CACHE = "shiro-cache:";
    
    private static final String SERIAL_KEY="j-s-c";

    private JedisManager jedisManager;

    private String name;
    
    public JedisShiroCache(String name,JedisManager jedisManager) {
        this.name = name;
        this.jedisManager = jedisManager;
    }

    /**
     * 自定义relm中的授权/认证的类名加上授权/认证英文名字
     */
    public String getName() {
        if (name == null)
            return "";
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @SuppressWarnings("unchecked")
    @Override
    public V get(K key) throws CacheException {
        Object byteValue = null;
        try {
            byteValue = jedisManager.getObjectByKey(SERIAL_KEY,buildCacheKey(key));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("get cache error");
        }
        return (V)byteValue;
    }

    @Override
    public V put(K key, V value) throws CacheException {
        V previos = get(key);
        try {
        	jedisManager.putObjectByKey(SERIAL_KEY, buildCacheKey(key), value);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("put cache error");
        }
        return previos;
    }

    @Override
    public V remove(K key) throws CacheException {
        V previos = get(key);
        try {
        	jedisManager.delObjectByKey(SERIAL_KEY, buildCacheKey(key));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("remove cache error");
        }
        return previos;
    }

    @Override
    public void clear() throws CacheException {
    	
    }

    @Override
    public int size() {
        if (keys() == null)
            return 0;
        return keys().size();
    }

    @Override
    public Set<K> keys() {
        return null;
    }

    @Override
    public Collection<V> values() {
        return null;
    }

    private String buildCacheKey(Object key) {
        return REDIS_SHIRO_CACHE + getName() + ":" + key;
    }

}
