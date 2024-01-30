package com.skilldistillery.stack.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
	
	@PostMapping(path = "account" )
	public User UpdateAccount(@RequestBody User user, HttpServletRequest req, HttpServletResponse res, Principal principal){
		User updated = null;
		if(user != null) {
			try {
				updated = userService.Update(user);
				res.setStatus(201);
				
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
			
		}
		return updated;
		
	}
	
	@DeleteMapping(path = "account/{Id}" )
	public boolean DestroyAccount(@PathVariable("Id")int id, HttpServletRequest req, HttpServletResponse res, Principal principal){
		boolean deleted = false;
			try {
				deleted = userService.Destroy(id);
				res.setStatus(201);
				
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
			
		return deleted;
		
	}
	
	@GetMapping(path = "account/{Id}" )
	public boolean ReactivateAccount(@PathVariable("Id")int id, HttpServletRequest req, HttpServletResponse res, Principal principal){
		boolean reactivated = false;
		try {
			reactivated = userService.ReActivate(id);
			res.setStatus(201);
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return reactivated;
		
	}
}
