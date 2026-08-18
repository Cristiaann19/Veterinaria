package com.example.vet.Repository.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Trabajador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrabajadorRepository extends JpaRepository<Trabajador,Long> {
}
