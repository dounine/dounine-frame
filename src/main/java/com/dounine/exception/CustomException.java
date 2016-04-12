package com.dounine.exception;

public class CustomException extends RuntimeException{
	private static final long serialVersionUID = 6794838795960651420L;

	public CustomException(){
		super();
	}

	public CustomException(String message){
		super(message);
	}

	public CustomException(Throwable throwable){
		super(throwable);
	}

	public CustomException(String message, Throwable throwable){
		super(message, throwable);
	}
}
