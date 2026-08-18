package com.example.vet.Controller.GMedica;

import com.example.vet.Model.GestionMedica.HistorialClinico;
import com.example.vet.Service.GMedica.HistorialClinicoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/historial-clinico")
public class HistorialClinicoController {

    @Autowired
    private HistorialClinicoService service;

    @PostMapping
    public ResponseEntity<HistorialClinico> registrar(@RequestBody HistorialClinico historial) {
        return ResponseEntity.ok(service.guardar(historial));
    }

    // Endpoint para ver el historial de UNA mascota específica
    @GetMapping("/mascota/{mascotaId}")
    public List<HistorialClinico> listarPorMascota(@PathVariable Long mascotaId) {
        return service.buscarPorMascota(mascotaId);
    }
}