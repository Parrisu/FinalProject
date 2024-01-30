package com.skilldistillery.stack.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.repositories.FunctionRepository;
import com.skilldistillery.stack.repositories.NodeRepository;

@Service
public class FunctionServiceImpl implements FunctionService {
	
	@Autowired
	FunctionRepository funRepo;
	
	@Autowired
	NodeRepository nodeRepo;

	@Override
	public Function findById(int id) {
		return funRepo.findById(id).get();
		
	}
	
	@Override
	public List<Function> findByNode(int id){
		return funRepo.findByNodeId(id);
	}


}
