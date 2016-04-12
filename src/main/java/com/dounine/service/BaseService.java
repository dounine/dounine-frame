package com.dounine.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.dao.BaseRepository;
import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.StatusType;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:10:21 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 服务层基类 ]
 */
public class BaseService<T extends BaseDomain> {

	@Autowired
	protected BaseRepository<T> baseRepository;
	
	@Operator(story="添加:数据")
	public void insert(T t){
		t.setStatus(StatusType.NORMAL);
		baseRepository.insert(t);
	}
	
	@Operator(story="修改:数据")
	public void update(T t){
		baseRepository.update(t);
	}
	
	public List<T> select(T t){
		return baseRepository.select(t);
	}
	
	@Operator(story="删除:数据")
	@Transactional
	public void delete(T t){
		NotDelete.delete();
		t.setStatus(StatusType.DELETE);
		baseRepository.delete(t);
	}
	
	public Serializable count(T t){
		return baseRepository.count(t);
	}
	
	@Operator(story="冻结:数据")
	public void congeal(T t){
		t.setStatus(StatusType.CONGEAL);
		baseRepository.congeal(t);
	}
	
	@Operator(story="解冻:数据")
	public void thaw(T t){
		t.setStatus(StatusType.NORMAL);
		baseRepository.thaw(t);
	}
	
	public T find(T t){
		return baseRepository.find(t);
	}
	
	public List<Map<String, Object>> export(T t){
		return baseRepository.export(t);
	}
}
