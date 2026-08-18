package com.example.vet.Controller.GMedica;

import com.example.vet.Model.GestionMedica.Mascota;
import com.example.vet.Service.GMedica.MascotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/mascotas")
@CrossOrigin(origins = "*")
public class MascotaController {

    @Autowired
    private MascotaService mascotaService;

    @GetMapping
    public List<Mascota> listar() {
        return mascotaService.listarTodas();
    }

    @PostMapping
    public ResponseEntity<?> crear(@RequestBody Mascota mascota) {
        System.out.println("DATOS RECIBIDOS: " + mascota.getNombre());
        if (mascota.getCliente() != null) {
            System.out.println("ID DEL CLIENTE: " + mascota.getCliente().getId());
        } else {
            System.out.println("EL CLIENTE LLEGÓ NULO DESDE EL JSON");
        }

        try {
            return ResponseEntity.ok(mascotaService.guardar(mascota));
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Mascota> obtenerPorId(@PathVariable Long id) {
        Mascota mascota = mascotaService.buscarPorId(id);
        return mascota != null ? ResponseEntity.ok(mascota) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        mascotaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Mascota> actualizar(@PathVariable Long id, @RequestBody Mascota mascota) {
        mascota.setId(id);
        return ResponseEntity.ok(mascotaService.guardar(mascota));
    }
}