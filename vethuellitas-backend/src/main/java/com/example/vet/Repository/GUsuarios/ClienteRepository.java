package com.example.vet.Repository.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Cliente;
import com.example.vet.DTO.ClienteDTO;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long> {

    @Query("SELECT new com.example.vet.DTO.ClienteDTO(" +
            "c.id, c.dni, c.nombres, c.apellidos, c.direccion, c.telefono, c.correo, " +
            "size(c.mascotas)) " +
            "FROM Cliente c")
    List<ClienteDTO> findAllClientesConContador();

    boolean existsByDni(String dni);
}
