package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class NodeMemberTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private NodeMember nodeMember;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAStack");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		NodeMemberId nmid = new NodeMemberId(1, 1);
		nodeMember = em.find(NodeMember.class, nmid);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		nodeMember = null;
	}

	@Test
	void test_user_mapping() {
		assertNotNull(nodeMember);
		assertNotNull(nodeMember.getUser());
		assertEquals(1, nodeMember.getUser().getId());
	}
	
	@Test
	void test_node_mapping() {
		assertNotNull(nodeMember);
		assertNotNull(nodeMember.getNode());
		assertEquals(1, nodeMember.getNode().getId());
	}
	
	@Test
	void test_approved_mapping() {
		assertNotNull(nodeMember);
		assertTrue(nodeMember.isApproved());
	}
	
	@Test
	void test_node_role_mapping() {
		assertNotNull(nodeMember);
		assertNotNull(nodeMember.getNodeRole());
		assertEquals(1, nodeMember.getNodeRole().getId());
	}
	
	
	

}
