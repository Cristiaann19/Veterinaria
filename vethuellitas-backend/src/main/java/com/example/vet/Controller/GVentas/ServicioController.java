package com.example.vet.Controller.GVentas;

import com.example.vet.DTO.ServicioRequestDTO;
import com.example.vet.Model.GestionVentas.Servicio;
import com.example.vet.Service.GVentas.ServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/servicios")
@CrossOrigin(origins = "*")
public class ServicioController {

    @Autowired
    private ServicioService servicioService;

    @GetMapping("/activos")
    public List<Servicio> listarActivos() {
        return servicioService.listarActivos();
    }

    @GetMapping
    public List<Servicio> listar() {
        return servicioService.listar();
    }

    @PostMapping
    public ResponseEntity<Servicio> crear(@RequestBody ServicioRequestDTO dto) {
        return ResponseEntity.ok(servicioService.crear(dto));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Servicio> actualizar(@PathVariable Long id, @RequestBody ServicioRequestDTO dto) {
        return ResponseEntity.ok(servicioService.actualizar(id, dto));
    }

}