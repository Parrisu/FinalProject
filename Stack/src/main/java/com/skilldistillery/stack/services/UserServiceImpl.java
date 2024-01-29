package com.skilldistillery.stack.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserRepository userRepo;

	@Override
	public User Update(User user) {
		return userRepo.saveAndFlush(user);
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	
	@Override
	public boolean Destroy(int id) {
		userRepo.deleteById(id);
		return !userRepo.existsById(id);
	}

}
