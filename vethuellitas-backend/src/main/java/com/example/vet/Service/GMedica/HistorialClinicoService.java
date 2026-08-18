package com.example.vet.Service.GMedica;

import com.example.vet.Model.GestionMedica.HistorialClinico;
import com.example.vet.Repository.GMedica.HistorialClinicoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HistorialClinicoService {

    @Autowired
    private HistorialClinicoRepository historialClinicoRepository;

    public List<HistorialClinico> listarTodos() {
        return historialClinicoRepository.findAll();
    }

    public List<HistorialClinico> buscarPorMascota(Long mascotaId) {
        return historialClinicoRepository.findByMascotaId(mascotaId);
    }

    public HistorialClinico guardar(HistorialClinico historial) {
        return historialClinicoRepository.save(historial);
    }

    public void eliminar(Long id) {
        historialClinicoRepository.deleteById(id);
    }
}