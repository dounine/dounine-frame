package com.dounine.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.dao.product.ProductNavDao;
import com.dounine.domain.product.ProductNav;
import com.dounine.finals.Finals;
import com.dounine.exception.CustomException;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.product ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月11日 下午3:50:57 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 产品导航业务类 ]
 */
@Service
@Operator(name="产品导航")
public class ProductNavService extends BaseService<ProductNav> {
	
	@Autowired
	private ProductNavDao productNavDao;
	
	public List<ProductNav> all(){
		List<ProductNav> productNavs = productNavDao.all();
		for(ProductNav productNav : productNavs){
			findChildren(productNav);
		}
		return productNavs;
	}
	
	public List<ProductNav> list(){
		return productNavDao.list();
	}
	
	public void findChildren(ProductNav productNav){
		List<ProductNav> productNavs = productNavDao.findRelationMyself(productNav);
		if(null!=productNavs&&productNavs.size()>0){
			productNav.setChildren(productNavs);
			for(ProductNav _productNav : productNavs){
				findChildren(_productNav);
			}
		}
	}
	
	public List<ProductNav> testChilren(){
		ProductNav productNav = new ProductNav();
		productNav.setId(3);
		return productNavDao.findRelationMyself(productNav);
	}

	@Override
	@Transactional
	public void delete(ProductNav productNav) {
		List<ProductNav> productNavs = productNavDao.findRelationMyself(productNav);
		if(null!=productNavs&&productNavs.size()>0){
			throw new CustomException(Finals.DATAINTEGRITY_STRING);
		}
		super.delete(productNav);
	}
}
