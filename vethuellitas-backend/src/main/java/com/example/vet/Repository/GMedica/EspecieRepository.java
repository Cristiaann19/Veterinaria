package com.example.vet.Repository.GMedica;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.vet.Model.GestionMedica.Especie;

public interface EspecieRepository extends JpaRepository<Especie, Long> {
}
