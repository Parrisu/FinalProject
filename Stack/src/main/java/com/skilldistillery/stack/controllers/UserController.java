package com.skilldistillery.stack.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.AuthException;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.services.AuthService;
import com.skilldistillery.stack.services.UserService;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({ "api/users" })
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private AuthService authService;

	@PutMapping({ "address" })
	public Address setAddressForUser(@RequestBody Address address,
			Principal principal) throws EntityDoesNotExistException, InvalidEntityException {
		User user = authService.getUserByUsername(principal.getName());
		return userService.updateUserAddress(user.getId(), address);
	}

	@GetMapping({ "address" })
	public Address getAddressForUser(@PathVariable("userId") int userId, Principal principal)
			throws AuthException, EntityDoesNotExistException {
		authService.verifyUserIdMatches(principal.getName(), userId);
		return userService.getUserAddress(userId);
	}
}
