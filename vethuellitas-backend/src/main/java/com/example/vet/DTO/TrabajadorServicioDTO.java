package com.example.vet.DTO;

import lombok.Data;

@Data
public class TrabajadorServicioDTO {
    private Long trabajadorId;
    private String trabajadorNombre;
    private String cargo;
    private String estado;
}