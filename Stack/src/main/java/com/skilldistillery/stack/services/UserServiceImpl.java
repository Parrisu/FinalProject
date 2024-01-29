package com.skilldistillery.stack.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private AddressService addressService;

	@Override
	public Address updateUserAddress(int userId, Address address) throws EntityDoesNotExistException, InvalidEntityException {
		User user = userRepo.findById(userId).orElse(null);
		if (user == null) {
			throw new EntityDoesNotExistException("User does not exist for id " + userId + ".");
		}
		address = addressService.createAddress(address);
		user.setAddress(address);
		userRepo.saveAndFlush(user);
		return address;
	}

	@Override
	public Address getUserAddress(int userId) throws EntityDoesNotExistException {
		User user = userRepo.findById(userId).orElse(null);
		if (user == null) {
			throw new EntityDoesNotExistException("User does not exist.");
		}
		return user.getAddress();
	}

}
