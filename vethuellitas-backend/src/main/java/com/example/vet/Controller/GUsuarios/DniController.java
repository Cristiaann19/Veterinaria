package com.example.vet.Controller.GUsuarios;

import com.example.vet.DTO.DniResponseDTO;
import com.example.vet.Service.GUsuarios.DniService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dni")
public class DniController {

    private static final String REGEX_DNI = "^\\d{8}$";

    @Autowired
    private DniService dniService;

    @GetMapping("/{dni}")
    public ResponseEntity<DniResponseDTO> consultar(@PathVariable String dni) {
        if (dni == null || !dni.matches(REGEX_DNI)) {
            throw new IllegalArgumentException("El DNI debe tener 8 digitos");
        }
        return ResponseEntity.ok(dniService.consultarDni(dni));
    }
}
