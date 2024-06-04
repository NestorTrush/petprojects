package com.striped.practice.users.core;

public class ProjectFilter {
    private String name;
    private String completed = "All";

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompleted() {
        return completed;
    }

    public void setCompleted(String completed) {
        this.completed = completed;
    }

}
