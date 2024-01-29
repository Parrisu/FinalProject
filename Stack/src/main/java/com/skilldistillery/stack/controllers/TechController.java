package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.services.TechService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class TechController {
	
	@Autowired
	private TechService techService;
	
	@GetMapping(path = {"technologies", "technologies/"} )
	public List<Technology> showAllTech(HttpServletRequest req, HttpServletResponse res, Principal principal){
		List<Technology> tech = techService.showAllTech();
		return tech;
		
	}

}
