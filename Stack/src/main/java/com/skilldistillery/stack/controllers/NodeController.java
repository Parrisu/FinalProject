package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.services.NodeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class NodeController {
	
	@Autowired
	private NodeService nodeService;
	
	@GetMapping(path = {"nodes", "nodes/"} )
	public List<Node> showAllNodes(HttpServletRequest req, HttpServletResponse res, Principal principal){
		List<Node> nodes = nodeService.showAllNodes();
		return nodes;
	}
	
	@GetMapping(path = {"nodes/{name}"} )
	public List<Node> findByName(HttpServletRequest req, HttpServletResponse res,  @PathVariable("name") String name, Principal principal){
		List<Node> nodes = nodeService.findByNameContaining(name);
		return nodes;
	}
	
	
	
}
