package com.example.vet.Controller.GUsuarios;

import com.example.vet.DTO.TrabajadorServicioDTO;
import com.example.vet.Service.GUsuarios.TrabajadorServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/trabajador-servicio")
public class TrabajadorServicioController {

    @Autowired
    private TrabajadorServicioService trabajadorServicioService;

    // GET /api/trabajador-servicio/por-servicio/1
    @GetMapping("/por-servicio/{servicioId}")
    public ResponseEntity<List<TrabajadorServicioDTO>> obtenerPorServicio(
            @PathVariable Long servicioId) {
        return ResponseEntity.ok(
                trabajadorServicioService.obtenerTrabajadoresPorServicio(servicioId)
        );
    }
}
