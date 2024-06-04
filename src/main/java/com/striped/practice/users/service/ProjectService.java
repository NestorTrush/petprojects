package com.striped.practice.users.service;

import java.util.Collection;
import java.util.List;

import com.striped.practice.users.core.Project;

public interface ProjectService {
    Collection<Project> getProjects();

    Project saveProject(Project project);

    Project getProject(Integer id);

    void deleteProject(int id);

    List<Project> getProjectsByUserId(Integer userId);
}


