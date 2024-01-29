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
		User update = userRepo.findByUsername(user.getUsername());
		update.setAboutMe(user.getAboutMe());
		update.setFirstName(user.getFirstName());
		update.setLastName(user.getLastName());
		update.setProfileImageUrl(user.getProfileImageUrl());
		return userRepo.saveAndFlush(update);
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
