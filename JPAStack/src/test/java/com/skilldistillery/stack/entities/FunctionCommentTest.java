package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class FunctionCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private FunctionComment functionComment, functionReply;
	
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
		functionComment = em.find(FunctionComment.class, 1);
		functionReply = em.find(FunctionComment.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		functionComment = null;
		
	}

	@Test
	void test_FunctionComment_entity_mapping() {
		assertNotNull(functionComment);
		assertEquals("Java is for the birds", functionComment.getContent());
		
	}
	
	@Test
	void test_FunctionComment_Function_mapping() {
		assertNotNull(functionComment);
		assertEquals("Java meet up", functionComment.getFunction().getName());
	}

	@Test
	void test_FunctionComment_User_mapping() {
		assertNotNull(functionComment);
		assertEquals("Steve", functionComment.getUser().getFirstName());
	}
	
	@Test
	void test_FunctionComment_FunctionReply_mapping() {
		assertNotNull(functionComment);
		assertEquals(null, functionComment.getReply());
		assertEquals("You're for the birds ", functionReply.getContent());
	}

}
