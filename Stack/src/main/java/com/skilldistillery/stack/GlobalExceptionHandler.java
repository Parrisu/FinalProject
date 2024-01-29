package com.skilldistillery.stack;

import java.util.Map;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.skilldistillery.stack.exceptions.AuthException;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

import jakarta.servlet.http.HttpServletResponse;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({ InvalidEntityException.class })
	public Map<String, String> handleInvalidEntityException(HttpServletResponse res, InvalidEntityException ex) {
		res.setStatus(400);
		return ex.getErrors();
	}

	@ExceptionHandler({ AuthException.class })
	public void handleAuthException(HttpServletResponse res, AuthException ex) {
		res.setStatus(401);
	}

	@ExceptionHandler({EntityDoesNotExistException.class})
	public String handleAuthException(HttpServletResponse res, EntityDoesNotExistException ex) {
		res.setStatus(404);
		return ex.getLocalizedMessage();
	}

}
