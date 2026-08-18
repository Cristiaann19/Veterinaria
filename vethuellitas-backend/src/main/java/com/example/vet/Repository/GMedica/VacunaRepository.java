package com.example.vet.Repository.GMedica;

import com.example.vet.Model.GestionMedica.VacunaCatalogo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VacunaRepository extends JpaRepository<VacunaCatalogo,Long> {
}
