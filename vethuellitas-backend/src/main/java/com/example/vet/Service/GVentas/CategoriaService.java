package com.example.vet.Service.GVentas;

import com.example.vet.Model.GestionVentas.Categoria;
import com.example.vet.Repository.GVentas.CategoriaRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CategoriaService {

    private static final Logger logger = LoggerFactory.getLogger(CategoriaService.class);

    @Autowired
    private CategoriaRepository categoriaRepository;

    public List<Categoria> listar() {
        logger.info("Categorías Listadas");
        return categoriaRepository.findAll();
    }

    public Categoria guardar(Categoria c) {
        logger.info("Categoría Guardada");
        return categoriaRepository.save(c);
    }

    public void eliminar(Long id) {
        logger.info("Categoría Eliminada");
        categoriaRepository.deleteById(id);
    }
}