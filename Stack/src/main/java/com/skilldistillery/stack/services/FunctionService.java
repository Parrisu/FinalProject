package com.skilldistillery.stack.services;

import java.util.List;

import com.skilldistillery.stack.entities.Function;

public interface FunctionService {
	
	Function findById(int functionId);
	
	List<Function> findByNode(int id);

}
