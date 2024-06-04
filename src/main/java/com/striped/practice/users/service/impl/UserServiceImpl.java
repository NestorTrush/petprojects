package com.striped.practice.users.service.impl;

import com.striped.practice.users.core.User;
import com.striped.practice.users.repository.UsersRepository;
import com.striped.practice.users.service.UserService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private UsersRepository usersRepository;


    public UserServiceImpl(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }

    @Override
    public void saveUser(User user) {
        usersRepository.save(user);
    }
    @Override
    public void deleteUser(int id) {
        usersRepository.deleteById(id);
    }

    @Override
    public void setUsersRepository(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }
    @Override
    public List<User> listUsers() {
        return usersRepository.findAll();
    }
    @Override
    public User getUser(Integer id) {
        return usersRepository.getOne(id);
    }

    @Override
    public User getUserByUsername(String username) {
        return usersRepository.findByEmail(username);
    }

}
