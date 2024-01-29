package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.AuthException;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

public interface AuthService {
	public User register(User user) throws InvalidEntityException;

	public User getUserByUsername(String username);

	public void verifyUserIdMatches(String username, int userId) throws AuthException, EntityDoesNotExistException;
}
