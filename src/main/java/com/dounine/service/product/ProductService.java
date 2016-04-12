package com.dounine.service.product;

import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.domain.product.Product;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月7日 下午9:09:44 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品业务类 ]
 */
@Service
@Operator(name="产品")
public class ProductService extends BaseService<Product> {
	
}
