package com.striped.practice.users.exception;

import com.striped.practice.users.core.Project;


public class DuplicateProjectException extends RuntimeException {
    private final Project project;

    public DuplicateProjectException(Project project) {
        this.project = project;
    }

    public Project getProject() {
        return project;
    }
}