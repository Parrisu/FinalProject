package com.skilldistillery.stack.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.City;
import com.skilldistillery.stack.repositories.CityRepository;

@Service
public class CityServiceImpl implements CityService {

	@Autowired
	private CityRepository cityRepo;

	@Override
	public List<City> getAll() {
		return cityRepo.findAll();
	}

}
