package com.striped.practice.users.service.impl;

import java.util.Collection;
import java.util.List;

import com.striped.practice.users.core.Project;
import com.striped.practice.users.repository.ProjectRepository;
import com.striped.practice.users.service.ProjectService;
import org.springframework.stereotype.Service;


@Service
public class ProjectServiceImpl implements ProjectService {


    private final ProjectRepository projectRepository;

    public ProjectServiceImpl(ProjectRepository projectRepository) {
        this.projectRepository = projectRepository;
    }


    @Override
    public Collection<Project> getProjects() {
        return projectRepository.findAll();
    }

    @Override
    public Project saveProject(Project project) {
        return projectRepository.save(project);
    }

    @Override
    public Project getProject(Integer id) {
        return projectRepository.getOne(id);
    }

    @Override
    public void deleteProject(int id) {
        projectRepository.deleteById(id);
    }

    @Override
    public List<Project> getProjectsByUserId(Integer userId) {
        return projectRepository.findByOwnerId(userId);
    }
}

