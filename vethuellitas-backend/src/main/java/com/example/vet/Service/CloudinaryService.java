package com.example.vet.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;

    public String subir(MultipartFile archivo) throws IOException {
        Map<?, ?> resultado = cloudinary.uploader().upload(
                archivo.getBytes(),
                ObjectUtils.asMap("resource_type", "auto")
        );
        return resultado.get("secure_url").toString();
    }

    public void eliminar(String url) throws IOException {
        String publicId = extraerPublicId(url);
        if (publicId != null) {
            cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        }
    }

    private String extraerPublicId(String url) {
        if (url == null || url.isBlank()) return null;
        try {
            String[] partes = url.split("/");
            int uploadIdx = -1;
            for (int i = 0; i < partes.length; i++) {
                if (partes[i].equals("upload")) {
                    uploadIdx = i;
                    break;
                }
            }
            if (uploadIdx < 0) return null;
            StringBuilder sb = new StringBuilder();
            for (int i = uploadIdx + 1; i < partes.length; i++) {
                if (i > uploadIdx + 1) sb.append("/");
                sb.append(partes[i]);
            }
            String ruta = sb.toString();
            int lastDot = ruta.lastIndexOf('.');
            if (lastDot > 0) ruta = ruta.substring(0, lastDot);
            return ruta;
        } catch (Exception e) {
            return null;
        }
    }
}