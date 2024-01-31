package com.skilldistillery.stack.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.repositories.FunctionRepository;
import com.skilldistillery.stack.repositories.NodeRepository;

@Service
public class FunctionServiceImpl implements FunctionService {

	@Autowired
	private FunctionRepository funRepo;

	@Autowired
	NodeRepository nodeRepo;

	@Override
	public Set<Function> searchFunctions(String searchQuery, String cityName, String stateAbbr, String username,
			Set<Technology> stack) {
		searchQuery = (searchQuery != null && searchQuery.isBlank()) ? null : searchQuery;
		cityName = (cityName != null && cityName.isBlank()) ? null : cityName;
		stateAbbr = (stateAbbr != null && stateAbbr.isBlank()) ? null : stateAbbr;
		username = (username != null && username.isBlank()) ? null : username;
		stack = (stack != null && stack.isEmpty()) ? null : stack;
		return funRepo.searchFunctions(searchQuery, cityName, stateAbbr, username, stack);
	}

	@Override
	public Function findById(int id) {
		return funRepo.findById(id).get();

	}

	@Override
	public List<Function> findByNode(int id) {
		return funRepo.findByNodeId(id);
	}

}
