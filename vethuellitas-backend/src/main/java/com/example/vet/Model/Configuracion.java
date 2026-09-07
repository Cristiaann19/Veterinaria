package com.example.vet.Model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "configuracion")
public class Configuracion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String logoUrl;
    private String heroVideoUrl;
    private String aboutImageUrl;
    private String siteName;
    private String telefono;
    private String correo;
}