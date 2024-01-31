package com.skilldistillery.stack.services;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.entities.User;

public interface NodeService {

	public List<Node> showAllNodes();

	public List<Node> findByNameContaining(String name);
	
	public Optional<Node> findById(int id);

	public Node create(String username, Node node);

	public List<User> joinNode(String username, Node node);

	public Node getNodeById(int id);

	public boolean leaveNode(String username, Node node);

	public List<User> findUserInNodeGroup(Node node);

	Set<Node> searchNodes(String searchQuery, String city, String stateAbbr, Set<Technology> stack);

}