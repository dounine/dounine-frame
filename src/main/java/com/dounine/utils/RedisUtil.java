package com.dounine.utils;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisShardInfo;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;
import redis.clients.util.Hashing;
import redis.clients.util.Sharded;

@SuppressWarnings("all")
public class RedisUtil {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private Jedis jedis;//非切片额客户端连接
    private JedisPool jedisPool;//非切片连接池
    private ShardedJedis shardedJedis;//切片额客户端连接（分布式）
    private ShardedJedisPool shardedJedisPool;//切片连接池
    
    private void inits(){
    	//initialPool(); 
    	//initialShardedPool(); 
    	shardedJedis = shardedJedisPool.getResource(); 
    	//jedis = jedisPool.getResource(); 
    	logger.debug("Redis Pool Init Finish.");
    }
    
    public Jedis getJedis(){
    	return jedis;
    }
    
    public final ShardedJedis getSharedJedis(){
    	return shardedJedis;
    }
 
    /**
     * 初始化非切片池
     */
    private void initialPool() 
    { 
        // 池基本配置 
        JedisPoolConfig config = new JedisPoolConfig();
        //config.setMaxTotal(20); 
        config.setMaxIdle(5); 
        config.setMaxWaitMillis(1000l);
        config.setTestOnBorrow(false); 
        jedisPool = new JedisPool(config,"localhost",6379);
    }
    
    /** 
     * 初始化切片池 
     */ 
    private void initialShardedPool() 
    { 
        // 池基本配置 
        JedisPoolConfig config = new JedisPoolConfig(); 
        config.setMaxTotal(20); 
        config.setMaxIdle(5); 
        config.setMaxWaitMillis(1000l); 
        config.setTestOnBorrow(false); 
        // slave链接 
        List<JedisShardInfo> shards = new ArrayList<JedisShardInfo>(); 
        
        shards.add(new JedisShardInfo("localhost", 6379, "master")); 
        shards.add(new JedisShardInfo("linux.dounine.com", 6379, "master1")); 
        // 构造池 
        shardedJedisPool = new ShardedJedisPool(config, shards,Hashing.MURMUR_HASH,Sharded.DEFAULT_KEY_TAG_PATTERN); 
    } 

    
    public static void main(String[] args) {
		Jedis jedis = new Jedis("localhost",6379);
		jedis.auth("lailake");
		System.out.println(jedis.get("lake50"));
	}
	
}



