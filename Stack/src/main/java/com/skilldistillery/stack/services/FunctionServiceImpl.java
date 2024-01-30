package com.skilldistillery.stack.services;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.repositories.FunctionRepository;

@Service
public class FunctionServiceImpl implements FunctionService {
	
	@Autowired
	private FunctionRepository funcRepo;

	@Override
	public Set<Function> getAll(String searchQuery, String username) {
		return funcRepo.getAll(searchQuery, username);
	}

}
