package com.dounine.shiro.cache;

import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.service.system.redis.JedisService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:18:58 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Jedis管理 ]
 */
public class JedisManager {
    
    @Autowired  
    private JedisService jedisService;

    public Object getObjectByKey(String serial_key,String key) throws Exception {
    	return jedisService.getObjectByKey(serial_key, key);
    }

    public void delObjectByKey(String serial_key,String key) throws Exception {
    	jedisService.delObjectByKey(serial_key, key);
    }

    public void putObjectByKey(String serial_key,String key,Object value)
            throws Exception {
    	jedisService.putObjectByKey(serial_key, key, value);
    }

}
