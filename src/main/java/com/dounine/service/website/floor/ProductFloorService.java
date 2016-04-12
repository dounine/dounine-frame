package com.dounine.service.website.floor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.dao.website.floor.ProductFloorDao;
import com.dounine.domain.website.floor.ProductFloor;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月24日 上午12:18:51 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品楼层业务类 ]
 */
@Service
@Operator(name="产品楼层")
@CacheConfig(cacheNames = {"ProductFloorCache"})  
public class ProductFloorService extends BaseService<ProductFloor> {
	@Autowired
	private ProductFloorDao productFloorDao;

	@Override
	@Cacheable
	public List<ProductFloor> select(ProductFloor productFloor) {
		return productFloorDao.select(productFloor);
	}
	
	
}
