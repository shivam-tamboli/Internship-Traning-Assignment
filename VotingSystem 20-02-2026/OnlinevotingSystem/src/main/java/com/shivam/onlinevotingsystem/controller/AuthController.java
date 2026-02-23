package com.shivam.onlinevotingsystem.controller;

import com.shivam.onlinevotingsystem.model.User;
import com.shivam.onlinevotingsystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(User user) {
        userService.registerUser(user);
        return "redirect:/";
    }

    @PostMapping("/login")
    public String login(String email, String password, HttpSession session, Model model) {

        User user = userService.login(email, password);

        if (user != null) {
            session.setAttribute("user", user);

            if (user.getRole().equals("ADMIN")) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/user/dashboard";
            }
        }

        model.addAttribute("error", "Invalid Credentials");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}