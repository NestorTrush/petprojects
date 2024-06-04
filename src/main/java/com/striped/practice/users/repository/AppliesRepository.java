package com.striped.practice.users.repository;

import com.striped.practice.users.core.Applies;
import com.striped.practice.users.core.ApplyId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AppliesRepository extends JpaRepository<Applies, ApplyId> {
    List<Applies> findByProjectId(Integer projectId);
}
