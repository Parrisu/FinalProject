package com.skilldistillery.stack.exceptions;

import java.util.Map;

public class InvalidEntityException extends Exception {

	private static final long serialVersionUID = -1348846314883744729L;

	private Map<String, String> errors;

	public InvalidEntityException() {
	}

	public InvalidEntityException(Map<String, String> errors) {
		this.errors = errors;
	}

	public Map<String, String> getErrors() {
		return errors;
	}

}