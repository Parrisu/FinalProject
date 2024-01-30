package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.services.NodeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class NodeController {

	@Autowired
	private NodeService nodeService;

	@GetMapping(path = { "nodes", "nodes/" })
	public List<Node> showAllNodes(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Node> nodes = nodeService.showAllNodes();
		return nodes;
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
			// TODO Auto-generated catch block
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
			// TODO Auto-generated catch block
			e.printStackTrace();
			res.setStatus(400);
			node = null;
		}
		return users;

	}

}
