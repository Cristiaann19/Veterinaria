package com.example.vet.Service;

import com.example.vet.Model.Configuracion;
import com.example.vet.Repository.ConfiguracionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfiguracionService {

    @Autowired
    private ConfiguracionRepository configuracionRepository;

    public Configuracion obtenerConfiguracion() {
        return configuracionRepository.findById(1L)
                .orElseGet(() -> {
                    Configuracion nueva = new Configuracion();
                    nueva.setSiteName("Huellitas Vet");
                    nueva.setTelefono("");
                    nueva.setCorreo("");
                    return configuracionRepository.save(nueva);
                });
    }

    public Configuracion actualizar(Configuracion datos) {
        Configuracion config = obtenerConfiguracion();
        if (datos.getLogoUrl() != null) config.setLogoUrl(datos.getLogoUrl());
        if (datos.getBannerUrl() != null) config.setBannerUrl(datos.getBannerUrl());
        if (datos.getHeroVideoUrl() != null) config.setHeroVideoUrl(datos.getHeroVideoUrl());
        if (datos.getAboutImageUrl() != null) config.setAboutImageUrl(datos.getAboutImageUrl());
        if (datos.getSiteName() != null) config.setSiteName(datos.getSiteName());
        if (datos.getTelefono() != null) config.setTelefono(datos.getTelefono());
        if (datos.getCorreo() != null) config.setCorreo(datos.getCorreo());
        return configuracionRepository.save(config);
    }
}