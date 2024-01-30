package com.skilldistillery.stack.repositories;

import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.skilldistillery.stack.entities.User;

@SpringBootTest
class UserRepositoryTest {
	@Autowired
	private UserRepository userRepo;
	

	@Test
	void test_get_members_by_nodeId() {
		List<User> users = userRepo.getMembersByNodeId(1);
		assertFalse(users.isEmpty());
		System.out.println(users);
		
	}

}
