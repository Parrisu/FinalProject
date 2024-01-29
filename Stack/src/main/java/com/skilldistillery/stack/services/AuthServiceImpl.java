package com.skilldistillery.stack.services;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private PasswordEncoder pwE;

	@Override
	public User register(User user) throws InvalidEntityException {
		Map<String, String> errors = new HashMap<>();
		if (!validateField(user.getUsername(), 45)) {
			errors.put("username",
					"Username must not be blank and must be under 45 characters in length with no spaces.");
		}

		if (userRepo.existsByUsername(user.getUsername())) {
			errors.put("username", "Username is taken by another user.");
		}

		if (!validatePassword(user.getPassword())) {
			errors.put("password",
					"Username must not be blank and must be between 8 and 50 characters long, with at least one letter and number.");
		}

		if (!validateEmail(user.getEmail())) {
			errors.put("email", "Email must not be blank and must be a valid email.");
		}

		if (userRepo.existsByEmail(user.getEmail())) {
			errors.put("email", "Email is taken by another user.");
		}

		if (!validateField(user.getFirstName(), 45)) {
			errors.put("firstName", "First name must not be blank and must be under 45 characters in length.");
		}

		if (!validateField(user.getLastName(), 45)) {
			errors.put("lastName", "Last name must not be blank and must be under 45 characters in length.");
		}

		if (user.getProfileImageUrl() != null && 2000 < user.getProfileImageUrl().length()) {
			errors.put("profileImageUrl", "Profile image url may not be over 2000 characters.");
		}

		if (!errors.isEmpty()) {
			throw new InvalidEntityException(errors);
		}

		user.setEnabled(true);
		user.setRole("standard");
		user.setPassword(pwE.encode(user.getPassword()));
		return userRepo.saveAndFlush(user);
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	// ------------------------------ Validation ------------------------------
	private boolean validateField(String field, int maxLength) {
		return field != null && !field.isBlank() && field.length() < maxLength && !field.contains("\\s");
	}

	public boolean validatePassword(String password) {
		boolean isValid = password != null && !password.isBlank() && 8 <= password.length() && password.length() <= 50;
		if (isValid) {
			Pattern pattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");
			Matcher matcher = pattern.matcher(password);
			isValid = matcher.matches();
		}
		return isValid;
	}

	public boolean validateEmail(String email) {
		boolean isValid = (email != null && !email.isBlank() && email.length() < 255);
		if (isValid) {
			Pattern pattern = Pattern.compile(".+\\@.+\\..+");
			Matcher matcher = pattern.matcher(email);
			isValid = matcher.matches();
		}
		return isValid;
	}

}
