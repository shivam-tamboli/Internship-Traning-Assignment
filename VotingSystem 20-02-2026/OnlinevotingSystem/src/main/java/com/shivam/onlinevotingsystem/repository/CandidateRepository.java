package com.shivam.onlinevotingsystem.repository;

import com.shivam.onlinevotingsystem.model.Candidate;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CandidateRepository extends JpaRepository<Candidate, Long> {
}