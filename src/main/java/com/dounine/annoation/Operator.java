package com.dounine.annoation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD,ElementType.METHOD,ElementType.TYPE})  
public @interface Operator {

	public String story() default "";//执行方法故事
	public String name() default "";//类名
	public boolean operatorClass() default true;//是否是标记日志类
}
