package com.shivam.onlinevotingsystem.controller;

import com.shivam.onlinevotingsystem.model.User;
import com.shivam.onlinevotingsystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("candidates", userService.getAllCandidates());
        return "user-dashboard";
    }

    @PostMapping("/vote/{id}")
    public String vote(@PathVariable Long id, HttpSession session) {

        User user = (User) session.getAttribute("user");

        userService.castVote(id, user);

        return "redirect:/user/dashboard";
    }
}