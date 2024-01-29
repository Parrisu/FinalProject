package com.skilldistillery.stack.services;

import java.util.List;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.repositories.NodeRepository;

public class NodeServiceImpl implements NodeService {

	private NodeRepository nodeRepo;
	private Node node;
	
	@Override
	public List<Node> showAllNodes() {
		
		return nodeRepo.findAll();
	}


}
