package com.example.vet.DTO;

import lombok.Data;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
public class LoginResponse {
    private String token;
    private String correo;
    private String rol;
    private Long trabajadorId;
    private String nombre;
    private Long clienteId;
}