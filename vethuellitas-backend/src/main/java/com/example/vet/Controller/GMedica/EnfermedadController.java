package com.example.vet.Controller.GMedica;

import com.example.vet.DTO.EnfermedadDTO;
import com.example.vet.DTO.EnfermedadRequestDTO;
import com.example.vet.Model.GestionMedica.Enfermedad;
import com.example.vet.Service.GMedica.EnfermedadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/enfermedades")
@CrossOrigin(origins = "*")
public class EnfermedadController {

    @Autowired
    private EnfermedadService enfermedadService;

    @GetMapping
    public List<Enfermedad> listar() {
        return enfermedadService.listarTodas();
    }

    @PostMapping
    public ResponseEntity<EnfermedadDTO> crearEnfermedad(@RequestBody EnfermedadRequestDTO request){
        return ResponseEntity.ok(enfermedadService.crear(request));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Enfermedad> obtenerPorId(@PathVariable Long id) {
        Enfermedad enfermedad = enfermedadService.buscarPorId(id);
        return enfermedad != null ? ResponseEntity.ok(enfermedad) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        enfermedadService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<EnfermedadDTO> actualizar(
            @PathVariable Long id,
            @RequestBody EnfermedadRequestDTO request) {
        return ResponseEntity.ok(enfermedadService.actualizar(id, request));
    }
}