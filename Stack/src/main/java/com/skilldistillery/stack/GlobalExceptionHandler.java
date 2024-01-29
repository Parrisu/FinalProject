package com.skilldistillery.stack;

import java.util.Map;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.skilldistillery.stack.exceptions.InvalidEntityException;

import jakarta.servlet.http.HttpServletResponse;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({ InvalidEntityException.class })
	public Map<String, String> handleInvalidEntityException(HttpServletResponse res, InvalidEntityException ex) {
		res.setStatus(400);
		return ex.getErrors();
	}

}
