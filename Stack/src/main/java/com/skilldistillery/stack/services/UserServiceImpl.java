package com.skilldistillery.stack.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.repositories.AddressRepository;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private AddressRepository addressRepo;

	@Override
	public Address updateUserAddress(int userId, int addressId) throws EntityDoesNotExistException {
		User user = userRepo.findById(userId).orElse(null);
		if (user == null) {
			throw new EntityDoesNotExistException("User does not exist for id " + userId + ".");
		}
		Address address = addressRepo.findById(addressId).orElse(null);
		if (address == null) {
			throw new EntityDoesNotExistException("Address does not exist for id " + addressId + ".");
		}
		user.setAddress(address);
		userRepo.saveAndFlush(user);
		return address;
	}

}
