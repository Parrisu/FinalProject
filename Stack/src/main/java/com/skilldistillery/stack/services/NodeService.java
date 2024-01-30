package com.skilldistillery.stack.services;

import java.util.List;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.User;

public interface NodeService {
	
	public List<Node> showAllNodes();
	
	public List<Node> findByNameContaining(String name);
	
	public Node create(String username, Node node);
	
	public List<User> joinNode(String username, Node node);
	
	public Node getNodeById(int id);
	
	

}
