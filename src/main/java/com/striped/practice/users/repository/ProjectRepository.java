package com.striped.practice.users.repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import com.striped.practice.users.core.Project;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ProjectRepository extends JpaRepository<Project, Integer> {
    List<Project> findByOwnerId(Integer userId);
}