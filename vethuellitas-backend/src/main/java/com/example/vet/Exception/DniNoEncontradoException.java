package com.example.vet.Exception;

public class DniNoEncontradoException extends RuntimeException {

    public DniNoEncontradoException(String dni) {
        super("DNI no encontrado: " + dni);
    }
}
