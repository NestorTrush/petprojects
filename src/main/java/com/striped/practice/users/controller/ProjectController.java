package com.striped.practice.users.controller;

import com.striped.practice.users.core.Applies;
import com.striped.practice.users.core.Project;
import com.striped.practice.users.core.ProjectFilter;
import com.striped.practice.users.core.User;
import com.striped.practice.users.service.AppliesService;
import com.striped.practice.users.service.ProjectService;
import com.striped.practice.users.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/projects")
public class ProjectController {

    private final ProjectService projectService;
    private final UserService userService;
    private final AppliesService appliesService;

    public ProjectController(ProjectService projectService, UserService userService, AppliesService appliesService) {
        this.projectService = projectService;
        this.userService = userService;
        this.appliesService = appliesService;
    }

    @GetMapping("")
    public String viewProjects(Model model) {
        List<User> userList = userService.listUsers();
        HashMap<Integer, String> userMap = new HashMap<>();
        for (User user : userList) {
            userMap.put(user.getId(), user.getFirst_name() + " " + user.getLast_name());
        }
        model.addAttribute("usernames", userMap);
        model.addAttribute("projects", projectService.getProjects());
        model.addAttribute("filter", new ProjectFilter());
        return "view-projects";
    }

    @PostMapping("")
    public String filterProjects(@ModelAttribute("filter")ProjectFilter projectFilter, Model model) {
        List<User> userList = userService.listUsers();
        HashMap<Integer, String> userMap = new HashMap<>();
        for (User user : userList) {
            userMap.put(user.getId(), user.getFirst_name() + " " + user.getLast_name());
        }
        model.addAttribute("usernames", userMap);
        List<Project> filteredProjects = new ArrayList<>();
        Collection<Project> projects = projectService.getProjects();
        for(Project project : projects){
            if(projectFilter.getCompleted().equals("All") ||
                    projectFilter.getCompleted().equals("Completed") && project.getCompleted() ||
                    projectFilter.getCompleted().equals("In progress") && !project.getCompleted()){
                if(project.getName().contains(projectFilter.getName())){
                    filteredProjects.add(project);
                }
            }
        }
        model.addAttribute("projects", filteredProjects);
        model.addAttribute("filter", projectFilter);
        return "view-projects";
    }

    @GetMapping("/addProject")
    public String addProjectView(Model model) {
        model.addAttribute("project", new Project());
        return "add-project";
    }

    @PostMapping("/addProject")
    public String addProject(@ModelAttribute("project") Project project, RedirectAttributes redirectAttributes) {
        project.setCompleted(false);
        project.setStartTime(new Date());
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User currentUser = userService.getUserByUsername(userDetails.getUsername());
        project.setOwnerId(currentUser.getId());
        Project savedProject = projectService.saveProject(project);
        redirectAttributes.addFlashAttribute("savedProject", savedProject);
        redirectAttributes.addFlashAttribute("addProjectSuccess", true);
        return "redirect:/projects";
    }

    @GetMapping(value = "/{id}/delete")
    public String deleteUser(@PathVariable Integer id, Model model) {
        projectService.deleteProject(id);
        model.addAttribute("projects", projectService.getProject(id));
        return "redirect:/projects";
    }

    @GetMapping("/{id}")
    public String infoProject(@PathVariable Integer id, Model model) {
        Project project = projectService.getProject(id);
        model.addAttribute("projectinfo", project);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User currentUser = userService.getUserByUsername(userDetails.getUsername());
        List<Applies> appliesList = appliesService.listApplies(project.getId());
        if (currentUser.getId().equals(project.getOwnerId())) {
            loadAppliedUsers(model, appliesList);
        } else {
            boolean alreadyApplied = false;
            boolean alreadyAssigned = false;
            for (Applies applies : appliesList) {
                if (applies.getUserId().equals(currentUser.getId()))
                    alreadyApplied = true;
            }
            for (User user : project.getUsers()) {
                if (user.getId().equals(currentUser.getId()))
                    alreadyAssigned = true;
            }
            if (!alreadyApplied && !alreadyAssigned)
                model.addAttribute("applyUser", new Applies());
            else
                model.addAttribute("warning", "Already applied/assigned to the project");
        }
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

    @GetMapping("/assignUser/{projectId}/{userId}")
    public String assignUser(@PathVariable Integer projectId, @PathVariable Integer userId, Model model) {
        List<Applies> appliesList = appliesService.listApplies(projectId);
        for (Applies applies : appliesList) {
            if (applies.getUserId().equals(userId)) {
                appliesService.delete(applies);
                break;
            }
        }
        Project project = projectService.getProject(projectId);
        User user = userService.getUser(userId);

        project.getUsers().add(user);
        projectService.saveProject(project);
        appliesList = appliesService.listApplies(projectId);
        loadAppliedUsers(model, appliesList);
        model.addAttribute("projectinfo", project);
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

    @GetMapping("/declineUser/{projectId}/{userId}")
    public String declineUser(@PathVariable Integer projectId, @PathVariable Integer userId, Model model) {
        Project project = projectService.getProject(projectId);

        List<Applies> appliesList = appliesService.listApplies(projectId);
        for (Applies applies : appliesList) {
            if (applies.getUserId().equals(userId)) {
                appliesService.delete(applies);
                break;
            }
        }
        appliesList = appliesService.listApplies(projectId);
        loadAppliedUsers(model, appliesList);
        model.addAttribute("projectinfo", project);
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

    @GetMapping("/unassignUser/{projectId}/{userId}")
    public String unassignUser(@PathVariable Integer projectId, @PathVariable Integer userId, Model model) {
        Project project = projectService.getProject(projectId);
        User user = userService.getUser(userId);
        project.getUsers().remove(user);
        projectService.saveProject(project);
        model.addAttribute("projectinfo", project);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User currentUser = userService.getUserByUsername(userDetails.getUsername());
        List<Applies> appliesList = appliesService.listApplies(project.getId());
        if (currentUser.getId().equals(project.getOwnerId())) {
            loadAppliedUsers(model, appliesList);
        }
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

    private void loadAppliedUsers(Model model, List<Applies> appliesList) {
        List<User> appliedUsers = new ArrayList<>();
        for (Applies applies : appliesList) {
            User user1 = userService.getUser(applies.getUserId());
            user1.setEmail(applies.getDescription());
            appliedUsers.add(user1);
        }
        model.addAttribute("applies", appliedUsers);
    }

    @PostMapping("/applyToProject")
    public String applyToProject(@ModelAttribute("applyTo") Applies applies, @ModelAttribute("project_id") Integer projectId, Model model) {
        if (applies.getDescription() == null || applies.getDescription().isEmpty()) {
            model.addAttribute("warning", "Description could not be empty");
            model.addAttribute("applyUser", new Applies());
            return "info-project";
        }
        applies.setProjectId(projectId);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User currentUser = userService.getUserByUsername(userDetails.getUsername());
        applies.setUserId(currentUser.getId());
        appliesService.saveApply(applies);
        model.addAttribute("warning", "Successfully applied to the project");
        Project project = projectService.getProject(projectId);
        model.addAttribute("projectinfo", project);
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

    @GetMapping("/markCompleted/{projectId}")
    public String markCompleted(@PathVariable Integer projectId, Model model) {
        Project project = projectService.getProject(projectId);
        project.setCompleted(true);
        project.setFinishTime(new Date());
        projectService.saveProject(project);
        model.addAttribute("projectinfo", project);
        loadAppliedUsers(model, appliesService.listApplies(projectId));
        model.addAttribute("owner", userService.getUser(project.getOwnerId()));
        return "info-project";
    }

}