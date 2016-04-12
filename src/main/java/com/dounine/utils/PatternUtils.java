package com.dounine.utils;


public class PatternUtils {

	public static boolean simpleMatch(String pattern,String original){
		if(original.length()<pattern.length()){
			return false;
		}
		pattern = pattern.replace("*", "");
		return original.indexOf(pattern)>-1;
	}
	
	public static void main(String[] args) {
		System.out.println(PatternUtils.simpleMatch("*as*", "s"));
	}
}
