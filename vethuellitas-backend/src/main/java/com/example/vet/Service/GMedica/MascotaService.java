package com.example.vet.Service.GMedica;

import com.example.vet.Model.GestionMedica.Mascota;
import com.example.vet.Repository.GMedica.MascotaRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MascotaService {

    private static final Logger logger = LoggerFactory.getLogger(MascotaService.class);

    @Autowired
    private MascotaRepository mascotaRepository;

    public List<Mascota> listarTodas(){
        logger.info("MASCOTAS LISTADAS");
        return  mascotaRepository.findAll();
    }

    public Mascota guardar(Mascota mascota){
        logger.info("MASCOTA GUARDADA CORRECTAMENTE" + mascota);
        return mascotaRepository.save(mascota);
    }

    public Mascota buscarPorId(Long id){
        logger.info("MASCOTA POR ID");
        return mascotaRepository.findById(id).orElse(null);
    }

    public void eliminar(Long id){
        logger.info("MASCOTA ELIMINADA" + id);
        mascotaRepository.deleteById(id);
    }
}
