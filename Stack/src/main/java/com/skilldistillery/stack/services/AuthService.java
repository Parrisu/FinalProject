package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

public interface AuthService {
	
	public User register(User user) throws InvalidEntityException;
	public User getUserByUsername(String username);

}
