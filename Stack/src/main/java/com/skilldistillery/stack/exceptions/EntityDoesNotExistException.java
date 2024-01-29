package com.skilldistillery.stack.exceptions;

public class EntityDoesNotExistException extends Exception {

	private static final long serialVersionUID = -5044920003421942697L;
	
	
	public EntityDoesNotExistException() {}
	
	public EntityDoesNotExistException(String message) {
		super(message);
	}
}
