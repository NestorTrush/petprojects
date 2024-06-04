package com.striped.practice.users.core;


import org.springframework.stereotype.Component;
import javax.persistence.*;
import java.io.Serializable;

@Component
@Entity(name = "applies")
@IdClass(ApplyId.class)
public class Applies implements Serializable {

    private String description;

    @Id
    private Integer userId;

    @Id
    private Integer projectId;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }
}



