package com.example.vet.Service.GMedica;

import com.example.vet.Model.GestionMedica.HistorialVacunacion;
import com.example.vet.Repository.GMedica.HistorialVacunacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HistorialVacunacionService {

    @Autowired
    private HistorialVacunacionRepository historialVacunacionRepository;

    public List<HistorialVacunacion> listarTodos() {
        return historialVacunacionRepository.findAll();
    }

    public HistorialVacunacion guardar(HistorialVacunacion historial) {
        return historialVacunacionRepository.save(historial);
    }

    public List<HistorialVacunacion> buscarPorMascota(Long mascotaId) {
        return historialVacunacionRepository.findByMascotaId(mascotaId);
    }
}