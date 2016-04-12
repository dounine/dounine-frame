package com.dounine.enumtype;

public enum SortType {

	DAY(0),//天
	WEEK(1),//周
	MONTH(2),//月
	SEASON(3),//季
	YEAR(4),//年
	SEQUENCE(5),//序号
	ID(6),//编号
	HITS(7),//点击
	NAME(8),//名称
	NONE(9)//随机
	;
	
	private int value;
	
	private SortType(int value){
		 this.value = value;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public static SortType fromTo(int value)
	{
		SortType[] values = SortType.values();
		for (SortType dounineType : values)
		{
			if (dounineType.getValue() == value)
			{
				return dounineType;
			}
		}
		throw new IllegalArgumentException("类型不正确,不能识别为[" + value + "]的类型.");
	}
}
