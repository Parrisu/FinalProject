package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;

public interface UserService {
	Address updateUserAddress(int userId, int addressId) throws EntityDoesNotExistException;
}
