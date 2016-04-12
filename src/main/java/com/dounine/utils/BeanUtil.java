package com.dounine.utils;

import java.lang.reflect.Method;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.utils ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:20:41 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ java反射工具类 ]
 */
public class BeanUtil {

	public Class<?> classExists(String className){
		try {
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			if(null==classLoader)classLoader = BeanUtil.class.getClassLoader();
			return classLoader.loadClass(className);
		} catch (Exception e) {
			return null;
		}
	}
	
	public Method methodExists(Class<?> class1,String methodName){
		try {
			Method[] methods = class1.getDeclaredMethods();
			for(Method method : methods){
				if(method.getName().equals(methodName)){
					return method;
				}
			}
			return null;
		} catch (SecurityException e) {
			return null;
		}
	}
	
	public boolean parameterTypesExists(Method method){
		try {
			Class<?>[] cc =  method.getParameterTypes();
			if(0==cc.length){
				return true;
			}
			return false;
		} catch (SecurityException e) {
			return false;
		}
	}
	
	
}
