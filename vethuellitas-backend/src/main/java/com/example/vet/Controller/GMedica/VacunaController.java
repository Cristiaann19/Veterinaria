package com.example.vet.Controller.GMedica;

import com.example.vet.Model.GestionMedica.HistorialVacunacion;
import com.example.vet.Model.GestionMedica.VacunaCatalogo;
import com.example.vet.Service.GMedica.HistorialVacunacionService;
import com.example.vet.Service.GMedica.VacunaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/vacunas")
@CrossOrigin(origins = "*")
public class VacunaController {

    @Autowired
    private VacunaService vacunaService;

    @Autowired
    private HistorialVacunacionService historialVacunacionService;

    // Catálogo de vacunas
    @GetMapping("/catalogo")
    public List<VacunaCatalogo> listarCatalogo() {
        return vacunaService.listarTodas();
    }

    @DeleteMapping("/{id}")
    public void eliminarVacuna(@PathVariable Long id) {
        vacunaService.eliminar(id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<VacunaCatalogo> actualizar(@PathVariable Long id, @RequestBody VacunaCatalogo vacuna) {
        return ResponseEntity.ok(vacunaService.actualizar(id, vacuna));
    }

    @PostMapping("/guardar")
    public VacunaCatalogo guardarVacuna(@RequestBody VacunaCatalogo vacuna) {
        return vacunaService.guardar(vacuna);
    }

    // Registrar aplicación de vacuna
    @PostMapping("/aplicar")
    public HistorialVacunacion aplicarVacuna(@RequestBody HistorialVacunacion historial) {
        return historialVacunacionService.guardar(historial);
    }

    // Ver vacunas de una mascota
    @GetMapping("/mascota/{mascotaId}")
    public List<HistorialVacunacion> verVacunasMascota(@PathVariable Long mascotaId) {
        return historialVacunacionService.buscarPorMascota(mascotaId);
    }

}