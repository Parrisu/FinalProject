package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

public interface UserService {

	User Update(User user);

	User getUserByUsername(String username);

	boolean Destroy(int id);

	Address updateUserAddress(int userId, Address address) throws EntityDoesNotExistException, InvalidEntityException;

	Address getUserAddress(int userId) throws EntityDoesNotExistException;

	public boolean ReActivate(int id);
	
	User updateUserTech(int userId, Technology tech);

}
