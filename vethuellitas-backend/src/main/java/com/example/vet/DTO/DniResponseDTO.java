package com.example.vet.DTO;

import lombok.Data;

@Data
public class DniResponseDTO {
    private String dni;
    private String nombres;
    private String apePaterno;
    private String apeMaterno;
    private String direccion;
    private String distrito;
    private String provincia;
    private String departamento;
}
