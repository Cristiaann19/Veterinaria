package com.example.vet.Controller.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Usuario;
import com.example.vet.Service.GUsuarios.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/registro")
    public Usuario registrar(@RequestBody Usuario usuario) {
        return usuarioService.registrar(usuario);
    }

    @GetMapping("/{correo}")
    public Usuario buscar(@PathVariable String correo) {
        return usuarioService.buscarPorCorreo(correo);
    }
}