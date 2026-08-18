package com.example.vet.Repository.GMedica;

import com.example.vet.Model.GestionMedica.HistorialVacunacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistorialVacunacionRepository extends JpaRepository<HistorialVacunacion, Long> {
    List<HistorialVacunacion> findByMascotaId(Long mascotaId);
}
