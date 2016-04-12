package com.dounine.enumtype;

public enum TimeType {
	DATETIME(0),//日期
	TIMESTAMP(1),//日期+时间
	TIME(3);//多少天多少分
	
	private int value;
	
	private TimeType(int value){
		 this.value = value;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public static TimeType fromTo(int value)
	{
		TimeType[] values = TimeType.values();
		for (TimeType dounineType : values)
		{
			if (dounineType.getValue() == value)
			{
				return dounineType;
			}
		}
		throw new IllegalArgumentException("类型不正确,不能识别为[" + value + "]的类型.");
	}
}
