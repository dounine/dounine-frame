package com.dounine.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.AbstractHandlerExceptionResolver;

import com.dounine.exception.AuthenticationException;
import com.dounine.exception.CustomException;
import com.dounine.exception.ScheduleException;
import com.dounine.finals.Finals;


/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:26:25 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 控制器异常处理器 ]
 */
public class GlobalHandlerExceptionResolver extends AbstractHandlerExceptionResolver{
	
	private final Logger console = LoggerFactory.getLogger(this.getClass());
	
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {		String msgInfo = Finals.OPERATOR_FAILURE_STRING;
		String viewAame = "msg-error";
		ModelAndView modelAndView = new ModelAndView(viewAame);
		if(ex instanceof DuplicateKeyException){
			msgInfo = Finals.VALUE_EXISTS_STRING;
		}else if(ex instanceof ScheduleException){
			msgInfo = ex.getMessage();
		}else if(ex instanceof DataIntegrityViolationException){
			msgInfo = Finals.DATA_VALUE_NOT_EMPTY;
		}else if(ex instanceof CustomException){
			msgInfo = ex.getMessage();
		}else if(ex instanceof AuthenticationException){
			msgInfo = ex.getMessage();
		}else{
			viewAame = "controller-error";
			ex.printStackTrace();
		}
		console.info(ex.getMessage());
		modelAndView.addObject("message", msgInfo);
		return modelAndView;
	}

}
