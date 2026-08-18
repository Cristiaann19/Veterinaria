package com.example.vet.Controller.GUsuarios;

import com.example.vet.DTO.CitaDTO;
import com.example.vet.DTO.CitaRequestDTO;
import com.example.vet.DTO.DashboardDTO;
import com.example.vet.Model.GestionMedica.Mascota;
import com.example.vet.Model.GestionUsuarios.Cita;
import com.example.vet.Model.GestionUsuarios.Trabajador;
import com.example.vet.Repository.GMedica.MascotaRepository;
import com.example.vet.Service.GUsuarios.CitaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

// CitaController.java
@RestController
@RequestMapping("/api/citas")
public class CitaController {

    @Autowired
    private CitaService citaService;

    @Autowired
    private MascotaRepository mascotaRepository;

    @GetMapping
    public ResponseEntity<List<CitaDTO>> listarCitas() {
        return ResponseEntity.ok(citaService.listarCitas());
    }

    @PostMapping
    public ResponseEntity<CitaDTO> crearCita(@RequestBody @Valid CitaRequestDTO request) {
        return ResponseEntity.ok(citaService.crearCita(request));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<DashboardDTO> getDashboard(){
        return ResponseEntity.ok(citaService.getDashboard());
    }

    // Citas por cliente
    @GetMapping("/cliente/{clienteId}")
    public ResponseEntity<List<CitaDTO>> porCliente(@PathVariable Long clienteId) {
        return ResponseEntity.ok(citaService.listarPorCliente(clienteId));
    }

    // Cancelar
    @PatchMapping("/{id}/cancelar")
    public ResponseEntity<CitaDTO> cancelar(@PathVariable Long id) {
        return ResponseEntity.ok(citaService.cancelarCita(id));
    }

    // Cambiar estado (admin)
    @PatchMapping("/{id}/estado")
    public ResponseEntity<CitaDTO> cambiarEstado(
            @PathVariable Long id,
            @RequestParam String estado) {
        return ResponseEntity.ok(citaService.cambiarEstado(id, estado));
    }

    //Trabajadores disponibles
    @GetMapping("/trabajadores-disponibles")
    public ResponseEntity<List<Trabajador>> disponibles(
            @RequestParam Long servicioId,
            @RequestParam String fechaHora) {
        LocalDateTime fecha = LocalDateTime.parse(fechaHora);
        return ResponseEntity.ok(citaService.trabajadoresDisponibles(servicioId, fecha));
    }

    // ✅ Mascotas del cliente (para el formulario)
    @GetMapping("/mascotas/cliente/{clienteId}")
    public ResponseEntity<List<Mascota>> mascotasPorCliente(@PathVariable Long clienteId) {
        return ResponseEntity.ok(mascotaRepository.findByClienteId(clienteId));
    }
}