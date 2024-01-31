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

class ArticleCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ArticleComment articleComment, reply;
	
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
		articleComment = em.find(ArticleComment.class, 1);
		reply = em.find(ArticleComment.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		articleComment = null;
		
	}

	@Test
	void test_ArticleComment_entity_mapping() {
		assertNotNull(articleComment);
		assertEquals("Wrong node to ask that bro", articleComment.getContent());
		assertEquals("Wrong node to ask that bro", reply.getReply().getContent());
		
	}
	
	@Test
	void test_ArticleComment_Article_mapping() {
		assertNotNull(articleComment);
		assertEquals("What is life", articleComment.getArticle().getContent());
	}

	

}
