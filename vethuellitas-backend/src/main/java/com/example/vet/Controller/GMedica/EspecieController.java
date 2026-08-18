package com.example.vet.Controller.GMedica;

import com.example.vet.DTO.EspecieDTO;
import com.example.vet.Model.GestionMedica.Especie;
import com.example.vet.Repository.GMedica.EspecieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/especies")
public class EspecieController {

    @Autowired
    private EspecieRepository especieRepository;

    @GetMapping
    public ResponseEntity<List<EspecieDTO>> listar() {
        return ResponseEntity.ok(
                especieRepository.findAll()
                        .stream()
                        .map(e -> {
                            EspecieDTO dto = new EspecieDTO();
                            dto.setId(e.getId());
                            dto.setNombre(e.getNombre());
                            return dto;
                        })
                        .collect(Collectors.toList())
        );
    }
}