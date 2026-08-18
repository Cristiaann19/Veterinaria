package com.example.vet.Controller.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Trabajador;
import com.example.vet.Service.GUsuarios.TrabajadorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.vet.DTO.TrabajadorRequestDTO;
import java.util.List;

@RestController
@RequestMapping("/api/trabajadores")
public class TrabajadorController {

    @Autowired
    private TrabajadorService trabajadorService;

    @GetMapping
    public List<Trabajador> listar() {
        return trabajadorService.listarTodos();
    }

    @PostMapping
    public ResponseEntity<Trabajador> crear(@RequestBody TrabajadorRequestDTO dto) {
        Trabajador nuevo = trabajadorService.crear(dto);
        return ResponseEntity.ok(nuevo);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Trabajador> actualizar(@PathVariable Long id, @RequestBody TrabajadorRequestDTO dto) {
        Trabajador actualizado = trabajadorService.actualizar(id, dto);
        return ResponseEntity.ok(actualizado);
    }
}