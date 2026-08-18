package com.example.vet.Controller.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Horario;
import com.example.vet.Service.GUsuarios.HorarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/horarios")
public class HorarioController {

    @Autowired
    private HorarioService horarioService;

    @GetMapping("/trabajador/{id}")
    public List<Horario> porTrabajador(@PathVariable Long id) {
        return horarioService.buscarPorTrabajador(id);
    }

    @PostMapping
    public Horario asignar(@RequestBody Horario horario) {
        return horarioService.guardar(horario);
    }

    @PutMapping("/{id}")
    public Horario actualizar(@PathVariable Long id, @RequestBody Horario horario) {
        horario.setId(id);
        return horarioService.guardar(horario);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        horarioService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}