package com.skilldistillery.stack.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.repositories.NodeRepository;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class NodeServiceImpl implements NodeService {
	@Autowired
	private NodeRepository nodeRepo;
	@Autowired
	private UserRepository userRepo;
	
	
	@Override
	public List<Node> showAllNodes() {
		
		return nodeRepo.findAll();
	}


	@Override
	public List<Node> findByNameContaining(String name) {

		return nodeRepo.findByNameContaining(name);
	}


	@Override
	public Node create(String username, Node node) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			node.setUser(user);
			return nodeRepo.saveAndFlush(node);
		}
		node.setEnabled(true);
		return node;
	}
	
	


}
