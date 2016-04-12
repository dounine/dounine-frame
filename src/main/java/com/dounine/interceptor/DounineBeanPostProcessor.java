package com.dounine.interceptor;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

public class DounineBeanPostProcessor implements BeanPostProcessor{
	
	//init 方法前与后处理。
	
	@Override
	public Object postProcessAfterInitialization(Object bean, String beanName)
			throws BeansException {
		return bean;
	}

	@Override
	public Object postProcessBeforeInitialization(Object bean, String beanName)
			throws BeansException {
		//System.out.println("ICO容器初始化："+bean.getClass().getSimpleName()+":"+beanName);
		
		return bean;
	}

}
