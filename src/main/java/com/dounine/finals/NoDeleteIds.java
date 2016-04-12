package com.dounine.finals;

public final class NoDeleteIds {

	public static final String TIP_TEXT = "此条数据是系统级别的,不能进行删除操作.";
	
	public static boolean PassInt(int[] list,int pass){
		boolean s = false;
		for(int a : list){
			if(pass==a){
				s = true;
				break;
			}
		}
		return s;
	}
}
