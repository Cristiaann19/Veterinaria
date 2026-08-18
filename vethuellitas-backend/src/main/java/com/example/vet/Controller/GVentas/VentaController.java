package com.example.vet.Controller.GVentas;

import com.example.vet.DTO.VentaRequestDTO;
import com.example.vet.Model.GestionVentas.Venta;
import com.example.vet.Service.GVentas.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @PostMapping
    public ResponseEntity<Venta> realizarVenta(@RequestBody VentaRequestDTO dto) {
        return ResponseEntity.ok(ventaService.realizarVentaDTO(dto));
    }

    @GetMapping
    public List<Venta> listarTodas() {
        return ventaService.listarVentas();
    }

    @GetMapping("/cliente/{clienteId}")
    public List<Venta> porCliente(@PathVariable Long clienteId) {
        return ventaService.listarPorCliente(clienteId);
    }
}