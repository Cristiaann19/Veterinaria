package com.example.vet.Controller.GVentas;

import com.example.vet.DTO.PagosResumenDTO;
import com.example.vet.Service.GVentas.PagosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pagos")
public class PagosController {

    @Autowired
    private PagosService pagosService;

    @GetMapping("/resumen")
    public ResponseEntity<PagosResumenDTO> getResumen() {
        return ResponseEntity.ok(pagosService.getResumen());
    }
}