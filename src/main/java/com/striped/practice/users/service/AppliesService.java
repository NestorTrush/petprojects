package com.striped.practice.users.service;

import com.striped.practice.users.core.Applies;
import com.striped.practice.users.core.Project;

import java.util.List;

public interface AppliesService {
    void saveApply(Applies apply);

    List<Applies> listApplies(Integer projectId);

    void delete(Applies applies);
}
