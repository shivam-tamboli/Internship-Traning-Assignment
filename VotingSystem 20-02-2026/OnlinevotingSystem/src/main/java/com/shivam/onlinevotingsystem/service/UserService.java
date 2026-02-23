package com.shivam.onlinevotingsystem.service;

import com.shivam.onlinevotingsystem.model.Candidate;
import com.shivam.onlinevotingsystem.model.User;
import com.shivam.onlinevotingsystem.repository.CandidateRepository;
import com.shivam.onlinevotingsystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CandidateRepository candidateRepository;

    public User registerUser(User user) {
        user.setRole("USER");
        return userRepository.save(user);
    }

    public User login(String email, String password) {
        User user = userRepository.findByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }

        return null;
    }

    public List<Candidate> getAllCandidates() {
        return candidateRepository.findAll();
    }

    public boolean castVote(Long candidateId, User user) {

        if (user.isHasVoted()) {
            return false;
        }

        Candidate candidate = candidateRepository.findById(candidateId).orElse(null);

        if (candidate != null) {
            candidate.setVoteCount(candidate.getVoteCount() + 1);
            candidateRepository.save(candidate);

            user.setHasVoted(true);
            userRepository.save(user);

            return true;
        }

        return false;
    }
}