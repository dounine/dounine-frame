package com.dounine.service.system.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.redis ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:16:56 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Redis分布式缓存业务类 ]
 */
@Service
public class JedisService {

	@Autowired  
    private RedisTemplate<String, Object> redisTemplate;
	
	public void putObjectByKey(String serial_key,String key,Object value){
		redisTemplate.opsForHash().put(serial_key, key, value);
	}
	
	public void delObjectByKey(String serial_key,String key){
		if(redisTemplate.opsForHash().hasKey(serial_key, key)){
			redisTemplate.opsForHash().delete(serial_key, key);
		}
	}
	
	public Object getObjectByKey(String serial_key,String key){
		if(redisTemplate.opsForHash().hasKey(serial_key, key)){
			return redisTemplate.opsForHash().get(serial_key, key);
		}
		return null;
	}
	
	public void putStringByKey(final String key,final String value){
		redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection)
					throws DataAccessException {
				connection.set(key.getBytes(), value.getBytes());
				return null;
			}
		});
	}
	
	public void delStringByKey(final String key){
		redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection)
					throws DataAccessException {
				if(connection.exists(key.getBytes())){
					connection.del(key.getBytes());
				}
				return null;
			}
		});
	}
	
	
	public String getStringByKey(final String key){
		return redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection)
					throws DataAccessException {
				if(connection.exists(key.getBytes())){
					return new String(connection.get(key.getBytes()));
				}
				return null;
			}
		});
	}
	
}
