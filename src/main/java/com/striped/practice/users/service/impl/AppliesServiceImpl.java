package com.striped.practice.users.service.impl;

import com.striped.practice.users.core.Applies;
import com.striped.practice.users.repository.AppliesRepository;
import com.striped.practice.users.service.AppliesService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppliesServiceImpl implements AppliesService {

    private AppliesRepository appliesRepository;

    public AppliesServiceImpl(AppliesRepository appliesRepository) {
        this.appliesRepository = appliesRepository;
    }

    @Override
    public void saveApply(Applies apply) {
        appliesRepository.save(apply);
    }

    @Override
    public List<Applies> listApplies(Integer projectId) {
        return appliesRepository.findByProjectId(projectId);
    }

    @Override
    public void delete(Applies applies) {
        appliesRepository.delete(applies);
    }
}
