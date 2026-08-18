package com.example.vet.Repository.GVentas;

import com.example.vet.Model.GestionVentas.DetalleVenta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface DetalleVentaRepository extends JpaRepository<DetalleVenta,Long> {
    List<DetalleVenta>findByVentaId(Long ventaId);

}
