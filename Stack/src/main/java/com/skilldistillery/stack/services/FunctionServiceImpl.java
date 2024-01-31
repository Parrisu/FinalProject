package com.skilldistillery.stack.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.repositories.FunctionRepository;
import com.skilldistillery.stack.repositories.NodeRepository;

@Service
public class FunctionServiceImpl implements FunctionService {

	@Autowired
	private FunctionRepository funRepo;

//	@Autowired
//	private AttendeeRepository attRepo;

	@Autowired
	NodeRepository nodeRepo;

	@Override
	public Set<Function> getAll(String searchQuery, String username) {
		return funRepo.getAll(searchQuery, username);
	}

	@Override
	public Function findById(int id) {
		return funRepo.findById(id).get();

	}

	@Override
	public List<Function> findByNode(int id) {
		return funRepo.findByNodeId(id);
	}
	
	@Override
	public Function findByFunctionIdAndNodeId(int id, int fid) {
		return funRepo.findFunctionByIdAndNode(id, fid);
	}
	
	@Override
	public Function createFunction(int nodeId, Function function) {
		Node node = nodeRepo.findById(nodeId).get();
		function.setNode(node);
		return funRepo.saveAndFlush(function);
	}
	
	
//	@Override
//	public List<Attendee> findAttendeeByFunctionId(int id) {
//		return attRepo.findByFunction(id);
//	}

}
