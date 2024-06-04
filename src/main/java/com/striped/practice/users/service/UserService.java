package com.striped.practice.users.service;

import com.striped.practice.users.core.User;
import com.striped.practice.users.repository.UsersRepository;

import java.util.List;

public interface UserService {

    void saveUser(User user);

    void deleteUser(int id);

    void setUsersRepository(UsersRepository usersRepository);

    List<User> listUsers();

    User getUser(Integer id);

    User getUserByUsername(String username);
}
