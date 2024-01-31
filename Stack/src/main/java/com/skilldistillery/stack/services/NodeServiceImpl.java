package com.skilldistillery.stack.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.NodeMember;
import com.skilldistillery.stack.entities.NodeMemberId;
import com.skilldistillery.stack.entities.NodeRole;
import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.repositories.NodeMemberRepository;
import com.skilldistillery.stack.repositories.NodeRepository;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class NodeServiceImpl implements NodeService {

	@Autowired
	private NodeRepository nodeRepo;

	@Autowired
	private NodeMemberRepository nodeMemberRepo;

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
		if (user != null) {
			node.setUser(user);
			return nodeRepo.saveAndFlush(node);
		}
		node.setEnabled(true);
		return node;
	}

	@Override
	public List<User> joinNode(String username, Node node) {
		List<User> users = null;
		User user = userRepo.findByUsername(username);
		if (user != null) {
			NodeMemberId id = new NodeMemberId(node.getId(), user.getId());
			NodeMember nodeMember = new NodeMember();
			nodeMember.setId(id);
			nodeMember.setUser(user);
			nodeMember.setNode(node);
			NodeRole role = new NodeRole();
			role.setId(1);
			nodeMember.setNodeRole(role);
			nodeMember.setApproved(true);
			nodeMemberRepo.saveAndFlush(nodeMember);
			users = userRepo.getMembersByNodeId(node.getId());
		}
		return users;
	}

	@Override
	public Node getNodeById(int id) {
		return nodeRepo.findById(id).orElse(null);

	}

	@Override
	public boolean leaveNode(String username, Node node) {
		User user = userRepo.findByUsername(username);
		NodeMemberId id = new NodeMemberId(node.getId(), user.getId());
		NodeMember nodeMember = nodeMemberRepo.findById(id).orElse(null);
		if (nodeMember != null) {
			nodeMemberRepo.delete(nodeMember);
			return true;
		}
		return false;
	}

	@Override
	public Set<Node> searchNodes(String searchQuery, String city, String stateAbbr, Set<Technology> stack) {
		Set<Node> nodes = nodeRepo.searchNodes(searchQuery, city, stateAbbr, stack);
		return nodes;
	}

	public List<User> findUserInNodeGroup(Node node) {
		List<User> users = null;
		users = userRepo.getMembersByNodeId(node.getId());
		if (users == null) {
			return null;
		}
		return users;
	}

}
