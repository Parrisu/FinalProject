package com.skilldistillery.stack.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private PasswordEncoder pwE;

	@Override
	public User register(User user) {
		user.setEnabled(true);
		user.setRole("standard");
		user.setPassword(pwE.encode(user.getPassword()));
		return userRepo.saveAndFlush(user);
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}


}
