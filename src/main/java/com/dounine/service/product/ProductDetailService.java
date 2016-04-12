package com.dounine.service.product;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.domain.product.ProductDetail;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月7日 下午9:10:17 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品详细信息业务类 ]
 */
@Service
@Operator(name="产品详细信息")
public class ProductDetailService extends BaseService<ProductDetail> {

	@Override
	@Transactional
	public void insert(ProductDetail t) {
		if(null!=super.find(t)){//不能对同一条信息添加一条以上的重复数据
			throw new CustomException(Finals.ILLEGAL_OPERATOR);
		}
		super.insert(t);
	}
	
	
	
}
