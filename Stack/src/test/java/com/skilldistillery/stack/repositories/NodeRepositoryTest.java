package com.skilldistillery.stack.repositories;

import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.Set;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.skilldistillery.stack.entities.Node;

@SpringBootTest
class NodeRepositoryTest {

	@Autowired
	private NodeRepository nodeRepo;

	@Test
	void test_search_all_with_no_filters_returns_non_empty_set() {
		Set<Node> nodes = nodeRepo.searchNodes(null, null, null, null);
		assertFalse(nodes.isEmpty());
	}

}
