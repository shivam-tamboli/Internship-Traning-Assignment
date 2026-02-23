package com.shivam.onlinevotingsystem.service;

import com.shivam.onlinevotingsystem.model.Candidate;
import com.shivam.onlinevotingsystem.repository.CandidateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private CandidateRepository candidateRepository;

    public Candidate addCandidate(Candidate candidate) {
        return candidateRepository.save(candidate);
    }

    public void deleteCandidate(Long id) {
        candidateRepository.deleteById(id);
    }

    public List<Candidate> getAllCandidates() {
        return candidateRepository.findAll();
    }
}