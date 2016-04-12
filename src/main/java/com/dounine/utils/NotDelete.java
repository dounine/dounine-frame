package com.dounine.utils;

import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;

public class NotDelete {

	public static void delete(){
		if(Finals.NOT_DELETE){
			throw new CustomException(Finals.BOX_PROGRAMMER);
		}
	}
}
