package com.dounine.enumtype;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.enumtype ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:31:14 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 类型 ]
 */
public enum StatusType {

	NORMAL(0),
	CONGEAL(1),
	DELETE(2);
	
	private int value;
	
	private StatusType(int value){
		 this.value = value;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public static StatusType fromTo(int value)
	{
		StatusType[] values = StatusType.values();
		for (StatusType dounineType : values)
		{
			if (dounineType.getValue() == value)
			{
				return dounineType;
			}
		}
		throw new IllegalArgumentException("类型不正确,不能识别为[" + value + "]的类型.");
	}
}
