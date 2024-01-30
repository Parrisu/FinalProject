package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.services.FunctionService;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({ "api/functions" })
public class FunctionController {

	@Autowired
	private FunctionService functionService;

	@GetMapping
	public Set<Function> getAll(@RequestParam(name = "searchQuery", required = false) String searchQuery,
			Principal principal) {
		return functionService.getAll(searchQuery, principal.getName());
	}

}
