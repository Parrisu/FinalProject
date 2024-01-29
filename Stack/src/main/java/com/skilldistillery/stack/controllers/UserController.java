package com.skilldistillery.stack.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.services.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api/users")
public class UserController {
	
	@Autowired
	private UserService userServ;
	
	@PostMapping(path = "account" )
	public User UpdateAccount(@RequestBody User user, HttpServletRequest req, HttpServletResponse res, Principal principal){
		if(user != null) {
			try {
				userServ.Update(user);
				res.setStatus(201);
				
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
			
		}
		return user;
		
	}

}
