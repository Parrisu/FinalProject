package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.services.FunctionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({ "api/functions" })
public class FunctionController {

	@Autowired
	private FunctionService functionService;
	

	@GetMapping
	public Set<Function> getAll(@RequestParam(name = "searchQuery", required = false) String searchQuery,
			Principal principal) {
		String username = (principal == null) ? null : principal.getName();
		return functionService.getAll(searchQuery, username);
	}

//	@GetMapping({ "{id}/attendees" })
//	public List<Attendee> getAttendees(@PathVariable("id") int id, 
//			HttpServletRequest req, HttpServletResponse res,
//			Principal principal) {
//		
//		return functionService.findAttendeeByFunctionId(id);
//	}
	
	@GetMapping({"{fid}"})
	public Function getFunction(@PathVariable("fid") int fid, HttpServletRequest req, HttpServletResponse res) {
		
		return functionService.findById(fid);
		
	}
	
	@PostMapping
	public Function createFunction(@RequestBody Function function, HttpServletRequest req, HttpServletResponse res) {
		
		return functionService.createFunction(function);
		
	}
	
}
