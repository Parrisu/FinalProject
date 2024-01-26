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

class ArticleTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Article article;
	
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
		article = em.find(Article.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		article = null;
		
	}

	@Test
	void test_Article_entity_mapping() {
		assertNotNull(article);
		assertEquals("What is life", article.getContent());
		
	}
	
	@Test
	void test_Article_User_mapping() {
		assertNotNull(article);
		assertEquals("admin", article.getUser().getFirstName());
	}

	@Test
	void test_Article_Node_mapping() {
		assertNotNull(article);
		assertEquals("Super Java bros", article.getNode().getName());
		
	}
	

}
