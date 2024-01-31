package com.skilldistillery.stack.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.Technology;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.services.FunctionService;
import com.skilldistillery.stack.services.NodeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api/nodes")
public class NodeController {

	@Autowired
	private NodeService nodeService;

	@Autowired
	private FunctionService funServ;

	// Node Routing //////////////////////////////////////////////////

	@GetMapping
	public Set<Node> showAllNodes(@RequestParam(name = "searchQuery", required = false) String searchQuery,
			@RequestParam(name = "cityName", required = false) String cityName,
			@RequestParam(name = "stateAbbr", required = false) String stateAbbr,
			@RequestParam(name = "stack", required = false) Set<Technology> stack) {
		return nodeService.searchNodes(searchQuery, cityName, stateAbbr, stack);
	}

	@GetMapping(path={"{id}"})
	public Node findById(HttpServletRequest req, HttpServletResponse res, @PathVariable("id") int id,
			Principal principal) {
		Node node = nodeService.findById(id).orElse(null);
		if (node == null) {
			res.setStatus(404);
		}
		return node;

	}

	@PostMapping
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


	@PostMapping(path = { "{nodeId}/members" })
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

	@DeleteMapping(path = { "{nodeId}/leave" })
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

	@GetMapping(path = { "{nodeId}/members" })
	public List<User> searchForUserInNode(HttpServletRequest req, HttpServletResponse res,
			@PathVariable("nodeId") int nodeId, Principal principal) {
		Node node = nodeService.getNodeById(nodeId);
		return nodeService.findUserInNodeGroup(node);

	}

	// Function Routing //////////////////////////////////////////////////

	@GetMapping(path = { "{nodeId}/function" })
	public List<Function> findFunctionsByNode(HttpServletRequest req, HttpServletResponse res,
			@PathVariable("nodeId") int id, Principal principal) {
		return funServ.findByNode(id);

	}

	@PostMapping(path = { "{nodeId}/function" })
	public Function findFunctionById(@PathVariable("nodeId") int nodeId, @RequestBody Function function,
			HttpServletRequest req, HttpServletResponse res, Principal principal) {

		return funServ.createFunction(nodeId, function);

	}

	@PutMapping(path = { "{nodeId}/function" })
	public Function updateFunction(@PathVariable("nodeId") int nodeId, @RequestBody Function function,
			HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Function toUpdate = funServ.updateFunction(nodeId, function);
		if (toUpdate != null) {
			res.setStatus(201);
		} else {
			res.setStatus(404);
		}
		return toUpdate;

	}

	@PutMapping(path = { "{nodeId}/function/{fId}" })
	public Function destroyFunction(@PathVariable("nodeId") int nodeId, @PathVariable("fId") int fId,
			HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Function toUpdate = funServ.destroyFunction(nodeId, fId);
		if (toUpdate != null) {
			res.setStatus(201);
		} else {
			res.setStatus(404);
		}
		return toUpdate;

	}
}
