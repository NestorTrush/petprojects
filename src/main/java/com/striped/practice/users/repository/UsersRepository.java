package com.striped.practice.users.repository;

import com.striped.practice.users.core.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
    User getUserById(Integer id);
}
