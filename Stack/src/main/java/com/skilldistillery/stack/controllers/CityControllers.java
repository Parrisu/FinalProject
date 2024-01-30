package com.skilldistillery.stack.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.City;
import com.skilldistillery.stack.services.CityService;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api/cities")
public class CityControllers {

	@Autowired
	private CityService cityService;

	@GetMapping
	public List<City> getAll() {
		return cityService.getAll();
	}
}
