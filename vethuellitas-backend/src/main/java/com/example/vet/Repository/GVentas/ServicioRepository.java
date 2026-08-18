package com.example.vet.Repository.GVentas;

import com.example.vet.Model.GestionVentas.Servicio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServicioRepository extends JpaRepository <Servicio,Long> {
}
