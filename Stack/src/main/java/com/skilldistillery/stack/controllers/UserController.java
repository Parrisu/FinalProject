package com.skilldistillery.stack.controllers;

import java.security.Principal;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Address;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({"api/users"})
public class UserController {
	
	
	@PutMapping({"address"})
	public Address updateAddressForUser(Principal principal) {
		return null;
	}
}
