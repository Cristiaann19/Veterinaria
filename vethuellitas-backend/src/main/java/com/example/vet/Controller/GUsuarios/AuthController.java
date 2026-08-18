package com.example.vet.Controller.GUsuarios;

import com.example.vet.DTO.LoginRequest;
import com.example.vet.DTO.LoginResponse;
import com.example.vet.DTO.RegistroClienteDTO;
import com.example.vet.Service.GUsuarios.AuthService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/registro/cliente")
    public ResponseEntity<?> registrarCliente(@Valid @RequestBody RegistroClienteDTO dto) {
        authService.registrarCliente(dto);
        return ResponseEntity.ok("Cliente registrado correctamente");
    }
}