package com.dounine.mapper.product;

import java.util.List;

import com.dounine.domain.product.ProductNav;
import com.dounine.mapper.BaseMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.mapper.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月11日 下午3:38:26 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品导航映射接口 ]
 */
public interface ProductNavMapper extends BaseMapper<ProductNav>{

	public List<ProductNav> all();
	
	public List<ProductNav> findRelationMyself(ProductNav productNav);
	
	public List<ProductNav> list();
}
