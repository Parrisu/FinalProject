package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.User;

public interface AuthService {
	
	public User register(User user);
	public User getUserByUsername(String username);

}
