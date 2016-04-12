package com.dounine.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.mapper.BaseMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.dao ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:44:44 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 数据层基类 ]
 */
public abstract class BaseRepository<T> {
	
	@Autowired
    protected BaseMapper<T> mapper;
	
	public void insert(T t){
		mapper.insert(t);
	}
	
	public void update(T t){
		mapper.update(t);
	}
	
	public void delete(T t){
		mapper.delete(t);
	}
	
	public List<T> select(T t){
		return mapper.select(t);
	}
	
	public Serializable count(T t){
		return mapper.count(t);
	}
	
	public void congeal(T t){
		mapper.congeal(t);
	}
	
	public void thaw(T t){
		mapper.thaw(t);
	}
	
	public T find(T t){
		return mapper.find(t);
	}
	
	public List<Map<String, Object>> export(T t){
		return mapper.export(t);
	}
}
