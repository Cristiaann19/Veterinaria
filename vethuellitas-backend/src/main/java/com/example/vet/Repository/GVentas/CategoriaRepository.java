package com.example.vet.Repository.GVentas;

import com.example.vet.Model.GestionVentas.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Long> {

}