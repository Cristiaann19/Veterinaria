package com.example.vet.Service.GVentas;

import com.example.vet.Model.GestionVentas.Producto;
import com.example.vet.Repository.GVentas.ProductoRepository;
import com.example.vet.Service.GMedica.EnfermedadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductoService {

    private static final Logger logger = LoggerFactory.getLogger(ProductoService.class);

    @Autowired
    private ProductoRepository productoRepository;

    public List<Producto> listar() {
        logger.info("Productos Listados");
        return productoRepository.findAll();
    }

    public Producto guardar(Producto p) {
        logger.info("Producto Guardado");
        return productoRepository.save(p);
    }

    public void eliminar(Long id) {
        logger.info("Producto Eliminado");
        productoRepository.deleteById(id);
    }
}