package com.skilldistillery.stack.services;


import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

public interface UserService {
	public User Update(User user);
	public User getUserByUsername(String username);
	public boolean Destroy(int id);
	Address updateUserAddress(int userId, Address address) throws EntityDoesNotExistException, InvalidEntityException;
	Address getUserAddress(int userId) throws EntityDoesNotExistException;


}
