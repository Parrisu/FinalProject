package com.skilldistillery.stack.services;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;

public interface AddressService {
	Address createAddress(Address address) throws EntityDoesNotExistException, InvalidEntityException;
}
