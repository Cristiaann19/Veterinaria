package com.example.vet.DTO;

import lombok.Data;

@Data
public class LoginRequest {
    private String correo;
    private String password;
}
