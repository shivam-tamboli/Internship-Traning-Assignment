package com.shivam.onlinevotingsystem.controller;

import com.shivam.onlinevotingsystem.model.Candidate;
import com.shivam.onlinevotingsystem.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("candidates", adminService.getAllCandidates());
        return "admin-dashboard";
    }

    @PostMapping("/add")
    public String addCandidate(Candidate candidate) {
        adminService.addCandidate(candidate);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        adminService.deleteCandidate(id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/results")
    public String results(Model model) {
        model.addAttribute("candidates", adminService.getAllCandidates());
        return "results";
    }
}