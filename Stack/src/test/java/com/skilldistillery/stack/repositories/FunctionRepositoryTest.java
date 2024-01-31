package com.skilldistillery.stack.repositories;

import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.Set;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.skilldistillery.stack.entities.Function;

@SpringBootTest
class FunctionRepositoryTest {

	@Autowired
	private FunctionRepository funcRepo;

	@Test
	void test_filtering_none_returns_non_empty_list() {
		Set<Function> functions = funcRepo.searchFunctions(null, null, null, null, null);
		assertFalse(functions.isEmpty());
	}

}
