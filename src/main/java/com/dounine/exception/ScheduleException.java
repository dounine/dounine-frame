package com.dounine.exception;

public class ScheduleException extends RuntimeException{

	private static final long serialVersionUID = -217253163340061214L;

	public ScheduleException(){
		super();
	}

	public ScheduleException(String message){
		super(message);
	}

	public ScheduleException(Throwable throwable){
		super(throwable);
	}

	public ScheduleException(String message, Throwable throwable){
		super(message, throwable);
	}
}
