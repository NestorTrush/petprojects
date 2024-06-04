package com.striped.practice.users.controller;

import com.striped.practice.users.core.Project;
import com.striped.practice.users.core.User;
import com.striped.practice.users.service.ProjectService;
import com.striped.practice.users.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/users")
public class UsersController {

    private UserService userService;
    private ProjectService projectService;

    public UsersController(UserService userService, ProjectService projectService) {
        this.userService = userService;
        this.projectService = projectService;
    }

    @PostMapping(value = "/save")
    public String insertUser(@ModelAttribute("user_id") Integer userId, User user, Model model) {
        user.setId(userId);
        userService.saveUser(user);
        model.addAttribute("users", userService.listUsers());
        return "redirect:/users";
    }

    @PutMapping(value = "/update")
    public String updateUser(User user, Model model) {
        userService.saveUser(user);
        model.addAttribute("users", userService.listUsers());
        return "redirect:/";
    }

    @GetMapping(value = "/delete/{id}")
    public String deleteUser(@PathVariable Integer id, Model model) {
        userService.deleteUser(id);
        model.addAttribute("users", userService.listUsers());
        return "redirect:/";
    }

    @GetMapping("")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.listUsers());
        return "list";
    }

    @GetMapping("/insert")
    public String createUser(Model model) {
        model.addAttribute("user", new User());
        return "user";
    }

    @GetMapping("/update/{id}")
    public String updateUser(@PathVariable Integer id, Model model) {
        model.addAttribute("user", userService.getUser(id));
        return "user";
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public String infoUser(@PathVariable Integer id, Model model){
        model.addAttribute("ownedProjects", projectService.getProjectsByUserId(id));
        model.addAttribute("userinfo", userService.getUser(id));
        return "info-user";
    }

    @PostMapping("/assignProject")
    public String assignProject(@ModelAttribute("user_id") Integer userId, @ModelAttribute("project_id") Integer projectId, Model model){
        User user = userService.getUser(userId);
        Project project = projectService.getProject(projectId);
        for(Project assignedProject:user.getProjects()){
            if(assignedProject.getId().equals(projectId)){
                model.addAttribute("userinfo", user);
                model.addAttribute("errorMessage","Project is already assigned");
                return "info-project";
            }
        }
        user.getProjects().add(project);
        userService.saveUser(user);
        model.addAttribute("userinfo", user);
        return "info-user";
    }

    @GetMapping("/unassignProject/{userId}/{projectId}")
    public String unassignProject(@PathVariable Integer userId, @PathVariable Integer projectId, Model model){
        Project project = projectService.getProject(projectId);
        User user = userService.getUser(userId);
        user.getProjects().remove(project);
        userService.saveUser(user);
        model.addAttribute("userinfo", user);
        return "info-user";
    }

    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public ModelAndView logout()
    {
        ModelAndView retVal = new ModelAndView();
        retVal.setViewName("logout");
        return retVal;
    }
}
