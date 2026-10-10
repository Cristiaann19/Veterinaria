package com.example.vet.Service.GUsuarios;

import com.example.vet.DTO.ClienteDTO;
import com.example.vet.Model.GestionUsuarios.Cliente;
import com.example.vet.Repository.GUsuarios.ClienteRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ClienteService {

    private static final Logger logger = LoggerFactory.getLogger(ClienteService.class);

    @Autowired
    private ClienteRepository clienteRepository;

    public List<ClienteDTO> listarTodosConContador() {
        logger.info("CLIENTES MOSTRADOS");
        return clienteRepository.findAllClientesConContador();
    }

    public Cliente guardar(Cliente cliente) {
        logger.info("CLIENTE GUARDADO CORRECTAMENTE");
        return clienteRepository.save(cliente);
    }

    public Cliente actualizar(Long id, Cliente cliente) {
        Cliente existente = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado: " + id));

        if (cliente.getNombres() != null)   existente.setNombres(cliente.getNombres());
        if (cliente.getApellidos() != null) existente.setApellidos(cliente.getApellidos());
        if (cliente.getDni() != null)       existente.setDni(cliente.getDni());
        if (cliente.getDireccion() != null) existente.setDireccion(cliente.getDireccion());
        if (cliente.getTelefono() != null)  existente.setTelefono(cliente.getTelefono());
        if (cliente.getCorreo() != null)    existente.setCorreo(cliente.getCorreo());

        logger.info("CLIENTE ACTUALIZADO CORRECTAMENTE");
        return clienteRepository.save(existente);
    }

    public void eliminar(Long id) {
        Cliente cliente = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado: " + id));
        clienteRepository.delete(cliente);
        logger.info("CLIENTE ELIMINADO CORRECTAMENTE");
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id).orElse(null);
    }

}