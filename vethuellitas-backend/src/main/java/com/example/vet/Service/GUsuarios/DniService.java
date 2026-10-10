package com.example.vet.Service.GUsuarios;

import com.example.vet.DTO.DniResponseDTO;
import com.example.vet.Exception.DniNoEncontradoException;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientResponseException;

@Service
public class DniService {

    private static final Logger logger = LoggerFactory.getLogger(DniService.class);

    @Autowired
    private RestClient miapiRestClient;

    public DniResponseDTO consultarDni(String dni) {
        logger.info("CONSULTA DNI - MIAPI CLOUD");

        MiapiResponse respuesta;
        try {
            respuesta = miapiRestClient.get()
                    .uri("/v1/dni/{dni}", dni)
                    .retrieve()
                    .body(MiapiResponse.class);
        } catch (RestClientResponseException ex) {
            logger.error("MIAPI CLOUD RESPONDIO CODIGO {}", ex.getStatusCode().value());
            if (ex.getStatusCode().value() == 401 || ex.getStatusCode().value() == 403) {
                throw new RuntimeException("Token de MIAPI Cloud invalido o sin creditos");
            }
            throw new RuntimeException("El servicio de consulta DNI no esta disponible");
        } catch (ResourceAccessException ex) {
            logger.error("NO SE PUDO CONECTAR CON MIAPI CLOUD", ex);
            throw new RuntimeException("El servicio de consulta DNI no responde, intente mas tarde");
        }

        if (respuesta == null || !Boolean.TRUE.equals(respuesta.getSuccess())
                || respuesta.getDatos() == null || respuesta.getDatos().getNombres() == null) {
            throw new DniNoEncontradoException(dni);
        }

        return mapear(respuesta.getDatos());
    }

    private DniResponseDTO mapear(MiapiDatos datos) {
        DniResponseDTO dto = new DniResponseDTO();
        dto.setDni(datos.getDni());
        dto.setNombres(datos.getNombres());
        dto.setApePaterno(datos.getApePaterno());
        dto.setApeMaterno(datos.getApeMaterno());
        if (datos.getDomiciliado() != null) {
            dto.setDireccion(datos.getDomiciliado().getDireccion());
            dto.setDistrito(datos.getDomiciliado().getDistrito());
            dto.setProvincia(datos.getDomiciliado().getProvincia());
            dto.setDepartamento(datos.getDomiciliado().getDepartamento());
        }
        return dto;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class MiapiResponse {
        private Boolean success;
        private MiapiDatos datos;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class MiapiDatos {
        private String dni;
        private String nombres;
        @JsonProperty("ape_paterno")
        private String apePaterno;
        @JsonProperty("ape_materno")
        private String apeMaterno;
        private MiapiDomiciliado domiciliado;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class MiapiDomiciliado {
        private String direccion;
        private String distrito;
        private String provincia;
        private String departamento;
        private String ubigeo;
    }
}
