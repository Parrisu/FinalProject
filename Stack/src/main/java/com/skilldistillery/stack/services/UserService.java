package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.User;

public interface UserService {
	
	public User Update(User user);
	public User getUserByUsername(String username);
	public boolean Destroy(int id);

}
