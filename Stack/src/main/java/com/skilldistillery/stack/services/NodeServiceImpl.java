package com.skilldistillery.stack.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.repositories.NodeRepository;

@Service
public class NodeServiceImpl implements NodeService {

	private NodeRepository nodeRepo;
	private Node node;
	
	@Override
	public List<Node> showAllNodes() {
		
		return nodeRepo.findAll();
	}


	@Override
	public List<Node> findByNameContaining(String name) {
		// TODO Auto-generated method stub
		return nodeRepo.findByNameContaining(name);
	}
	
	


}
