package com.dounine.dao.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dounine.dao.BaseRepository;
import com.dounine.domain.product.ProductNav;
import com.dounine.mapper.product.ProductNavMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.dao.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月11日 下午3:50:08 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品导航数据层实现类 ]
 */
@Repository
public class ProductNavDao extends BaseRepository<ProductNav>{

	@Autowired
	private ProductNavMapper productNavMapper;
	
	public List<ProductNav> all(){
		return productNavMapper.all();
	}
	
	public List<ProductNav> findRelationMyself(ProductNav productNav){
		return productNavMapper.findRelationMyself(productNav);
	}
	
	public List<ProductNav> list(){
		return productNavMapper.list();
	}
}
