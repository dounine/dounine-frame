package com.dounine.mapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.mapper ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:25:08 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Dao基类 ]
 */
public abstract interface BaseMapper<T> {
	
	public void insert(T t);
	
	public void update(T t);
	
	public void edit(T t);
	
	public List<T> select(T t);
	
	public Serializable count(T t);
	
	public void delete(T t);
	
	public void congeal(T t);
	
	public void thaw(T t);
	
	public T find(T t);
	
	public List<Map<String, Object>> export(T t);
}
