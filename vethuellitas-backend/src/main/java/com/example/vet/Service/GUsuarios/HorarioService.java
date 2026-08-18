package com.example.vet.Service.GUsuarios;

import com.example.vet.Model.GestionUsuarios.Horario;
import com.example.vet.Repository.GUsuarios.HorarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HorarioService {
    @Autowired
    private HorarioRepository horarioRepository;

    public List<Horario> buscarPorTrabajador(Long trabajadorId) {
        return horarioRepository.findByTrabajadorId(trabajadorId);
    }

    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    public void eliminar(Long id) {
        horarioRepository.deleteById(id);
    }
}