package com.skilldistillery.stack.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.repositories.TechnologyRepository;

@Service
public class TechServiceImpl implements TechService {
	
	@Autowired
	private TechnologyRepository techRepo;
	


	@Override
	public List<Technology> showAllTech() {
		return techRepo.findAll();
	}

}
