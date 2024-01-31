package com.skilldistillery.stack.services;

import java.util.List;
import java.util.Set;

import com.skilldistillery.stack.entities.Function;

public interface FunctionService {
	Set<Function> getAll(String searchQuery, String username);

	Function findById(int functionId);

	List<Function> findByNode(int id);

}
