package com.dounine.interceptor;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.annoation.NoOperator;
import com.dounine.annoation.Operator;
import com.dounine.domain.system.log.Operation;
import com.dounine.domain.system.rbac.User;
import com.dounine.service.system.log.OperationService;
import com.dounine.service.system.rbac.UserService;
import com.dounine.utils.JsonUtil;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:27:05 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 操作日志记录类 ]
 */
public class OperationInterceptor {
	
	JsonUtil jsonUtil = new JsonUtil();
	
	public static OperationService operationService;
	
	@Autowired
	private UserService userService;
	
	public void throMethod(JoinPoint joinPoint,Exception ex){
		ex.printStackTrace();
	}
	
	public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
		Object object = pjp.proceed();
		Signature signature = pjp.getSignature();
		MethodSignature methodSignature = (MethodSignature) signature;
		Method method = methodSignature.getMethod();
		if(method.isAnnotationPresent(Operator.class)&&!signature.getClass().isAnnotationPresent(NoOperator.class)){
			List<Object> lists = new ArrayList<Object>();
			for(Object object2 : pjp.getArgs()){
				Class<?> executeClass = object2.getClass();
				if(executeClass.isAnnotationPresent(Operator.class)){
					lists.add(jsonUtil.toJson(object2));
				}else{
					lists.add(object2);
				}
			}
			Operation _operator = new Operation();
			_operator.setCreateTime(new Date());
			_operator.setAfterContent(jsonUtil.buildList(lists.size(), lists, null));
			if(method.getAnnotation(Operator.class).story().indexOf(":")>-1){
				String story = method.getAnnotation(Operator.class).story();
				Operator cc = pjp.getTarget().getClass().getAnnotation(Operator.class);
				if(null!=cc){
					String name = cc.name();
					_operator.setStory(story.replace(":", name));
				}else{
					_operator.setStory(story);
				}
			}else{
				_operator.setStory(method.getAnnotation(Operator.class).story());
			}
			_operator.setUserId(userService.find(new User((String) SecurityUtils.getSubject().getPrincipal())).getUserId());
			operationService.insert(_operator);
		}
		return object;
	}
}