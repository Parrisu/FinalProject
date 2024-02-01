package com.skilldistillery.stack.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.repositories.FunctionRepository;
import com.skilldistillery.stack.repositories.NodeRepository;
import com.skilldistillery.stack.repositories.UserRepository;
import com.skilldistillery.stack.services.FunctionService;
import com.skilldistillery.stack.services.NodeService;
import com.skilldistillery.stack.services.UserService;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({ "api/admin" })
public class AdminController {

	@Autowired
	private NodeService nodeService;

	@Autowired
	private NodeRepository nodeRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private UserService userService;

	@Autowired
	private FunctionRepository funcRepo;

	@Autowired
	private FunctionService funcService;

	@GetMapping({ "nodes" })
	public List<Node> getAllNodesForAdmin() {
		return nodeRepo.findAll();
	}

	@PutMapping({ "nodes/{nodeId}" })
	public Node updateNodeStatus(@PathVariable("nodeId") int nodeId, @RequestParam("status") boolean status)
			throws EntityDoesNotExistException {
		return this.nodeService.setEnabled(nodeId, status);
	}

	@GetMapping({ "users" })
	public List<User> getAllUsers() {
		return userRepo.findAll();
	}

	@PutMapping({ "users/{userId}" })
	public User setUserStatus(@PathVariable("userId") int userId, @RequestParam("status") boolean status)
			throws EntityDoesNotExistException {
		return userService.setUserStatus(userId, status);
	}

	@GetMapping({ "functions" })
	public List<Function> getAllFunctions() {
		return funcRepo.findAll();
	}

	@PutMapping({ "functions/{functionId}" })
	public Function setFunctionStatus(@PathVariable("functionId") int functionId,
			@RequestParam("status") boolean status) throws EntityDoesNotExistException {
		return funcService.setFunctionStatus(functionId, status);
	}

}
