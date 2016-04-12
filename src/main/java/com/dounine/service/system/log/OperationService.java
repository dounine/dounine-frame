package com.dounine.service.system.log;

import java.io.Serializable;
import java.util.List;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.dounine.annoation.NoOperator;
import com.dounine.domain.system.log.Operation;
import com.dounine.service.BaseService;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.log ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:11:58 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 操作日志业务类 ]
 */
@Service
@NoOperator
@CacheConfig(cacheNames={"operationCache"})
public class OperationService extends BaseService<Operation> {

	@Override
	@CachePut(key="#operation.id")
	public void insert(Operation operation) {
		super.insert(operation);
	}

	@Override
	@CachePut(key="#operation.id")
	public void update(Operation operation) {
		super.update(operation);
	}

	@Override
	public List<Operation> select(Operation operation) {
		return super.select(operation);
	}

	@Override
	@CachePut(key="#operation.id")
	public void delete(Operation operation) {
		NotDelete.delete();
		super.delete(operation);
	}

	@Override
	public Serializable count(Operation operation) {
		return super.count(operation);
	}

	@Override
	public void congeal(Operation operation) {
		super.congeal(operation);
	}

	@Override
	public void thaw(Operation operation) {
		super.thaw(operation);
	}

	@Override
	@Cacheable(key="#operation.id")
	public Operation find(Operation operation) {
		return super.find(operation);
	}

}
