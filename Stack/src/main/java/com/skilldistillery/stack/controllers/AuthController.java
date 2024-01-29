package com.skilldistillery.stack.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.services.AuthService;

import jakarta.servlet.http.HttpServletResponse;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
public class AuthController {

	@Autowired
	private AuthService authService;

	@PostMapping("register")
	public User register(@RequestBody User user, HttpServletResponse res) {
		user = authService.register(user);
		return user;
	}

	@GetMapping("authenticate")
	public User authenticate(Principal principal, HttpServletResponse res) {
		User user =  authService.getUserByUsername(principal.getName());
		user.setPassword(null);
		return user;
	}

}
