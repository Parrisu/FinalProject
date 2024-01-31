package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.repositories.FunctionRepository;
import com.skilldistillery.stack.services.FunctionService;
import com.skilldistillery.stack.services.NodeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class NodeController {

	@Autowired
	private NodeService nodeService;

	@Autowired
	private FunctionService funServ;
	
	@Autowired
	private FunctionRepository funRepo;

	@GetMapping(path = { "nodes", "nodes/" })
	public Set<Node> showAllNodes(@RequestParam(name = "searchQuery", required = false) String searchQuery,
			@RequestParam(name = "cityName", required = false) String cityName,
			@RequestParam(name = "stateAbbr", required = false) String stateAbbr) {
		return nodeService.searchNodes(searchQuery, cityName, stateAbbr);
	}

	@GetMapping(path = { "nodes/{name}" })
	public List<Node> findByName(HttpServletRequest req, HttpServletResponse res, @PathVariable("name") String name,
			Principal principal) {

		List<Node> nodes = nodeService.findByNameContaining(name);
		return nodes;

	}

	@PostMapping(path = { "nodes" })
	public Node addNode(HttpServletRequest req, HttpServletResponse res, @RequestBody Node node, Principal principal) {
		try {
			node = nodeService.create(principal.getName(), node);
			if (node == null) {
				res.setStatus(401);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			node = null;
		}
		return node;

	}

	@PostMapping(path = { "nodes/{nodeId}/members" })
	public List<User> joinNode(HttpServletRequest req, HttpServletResponse res, @PathVariable("nodeId") int nodeId,
			Principal principal) {
		List<User> users = null;
		Node node = nodeService.getNodeById(nodeId);
		try {
			if (node == null) {
				res.setStatus(404);

			} else {
				users = nodeService.joinNode(principal.getName(), node);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			node = null;
		}
		return users;

	}

	@GetMapping(path = { "nodes/{nodeId}/function" })
	public List<Function> findFunctionsByNode(HttpServletRequest req, HttpServletResponse res,
			@PathVariable("nodeId") int id, Principal principal) {
		return funServ.findByNode(id);

	}
//	@GetMapping(path = { "nodes/{nodeId}/function/{Id}" })
//	public Function findFunctionById(HttpServletRequest req, HttpServletResponse res, @PathVariable("Id") int id,
//			Principal principal) {
//		
//		return funServ.findById(id);
//		
//	}

	@DeleteMapping(path = { "nodes/{nodeId}/leave" })
	public void leaveNode(HttpServletRequest req, HttpServletResponse res, @PathVariable("nodeId") int nodeId,
			Principal principal) {
		Node node = nodeService.getNodeById(nodeId);

		if (node == null) {
			res.setStatus(404);

		} else {
			boolean leftNode = nodeService.leaveNode(principal.getName(), node);
			if (leftNode) {
				res.setStatus(204);

			} else {
				res.setStatus(404);
			}

		}

	}

	@GetMapping(path = { "nodes/{nodeId}/members" })
	public List<User> searchForUserInNode(HttpServletRequest req, HttpServletResponse res,
			@PathVariable("nodeId") int nodeId, Principal principal) {
		Node node = nodeService.getNodeById(nodeId);
		return nodeService.findUserInNodeGroup(node);

	}

}
