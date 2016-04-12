package com.dounine.service.website.floor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.dao.website.floor.FloorCellDao;
import com.dounine.domain.website.floor.FloorCell;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月24日 上午12:35:37 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品楼层单元格业务类 ]
 */
@Service
@Operator(name="产品楼层单元格")
@CacheConfig(cacheNames = {"ProductFloorCellCache"})  
public class FloorCellService extends BaseService<FloorCell> {
	@Autowired
	private FloorCellDao floorCellDao;

	@Override
	@Cacheable
	public List<FloorCell> select(FloorCell floorCell) {
		return floorCellDao.select(floorCell);
	}
	
	
}
