# Backend Veterinaria Huellitas

API REST para la clínica veterinaria "Huellitas". Gestiona clientes, mascotas, citas, servicios, trabajadores, ventas, vacunas, historial clínico y reportes de pagos. Es consumida por un frontend Angular que corre en `http://localhost:4200`.

## Stack tecnológico

| Tecnología | Versión | Uso |
|---|---|---|
| Java | 21 | Lenguaje |
| Spring Boot | 4.0.1 | Framework base |
| Maven Wrapper | - | Build (sin Maven global) |
| Spring WebMVC | Boot 4 | Capa REST |
| Spring Security + JJWT | 0.12.3 | Autenticación JWT |
| Spring Data JPA / Hibernate | Boot 4 | Persistencia |
| Bean Validation | Boot 4 | Validación de inputs |
| MySQL Connector/J | runtime | Driver MySQL |
| PostgreSQL | runtime | Driver alternativo (no configurado) |
| Lombok | - | `@Data`, generación de getters/setters |
| springdoc-openapi | 2.8.9 | Swagger UI / OpenAPI |
| spring-dotenv | 4.0.0 | Dependencia presente, **no usada** |
| Actuator | Boot 4 | Métricas / health |

## Requisitos previos

- JDK 21.
- MySQL 8 corriendo en `localhost:3306`.
- No se requiere Maven global: se usa el wrapper `mvnw.cmd` (Windows) / `mvnw` (Unix).

## Ejecución

```bash
# Compilar/verificar
.\mvnw.cmd -q compile

# Levantar la app (arranca en http://localhost:8080)
.\mvnw.cmd spring-boot:run

# Tests (solo existe un test de carga de contexto)
.\mvnw.cmd test
```

No hay lint/formatter/checkstyle configurado.

## Configuración (`src/main/resources/application.properties`)

| Propiedad | Valor | Descripción |
|---|---|---|
| `spring.datasource.url` | `jdbc:mysql://localhost:3306/veterinaria_web?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC` | BD local; se auto-crea si no existe |
| `spring.datasource.username` / `.password` | `root` / `123456` | Credenciales **hardcodeadas** (no usa variables de entorno pese al dep `spring-dotenv`) |
| `spring.jpa.hibernate.ddl-auto` | `update` | Hibernate crea/actualiza el esquema al arrancar. **No hay migraciones (Flyway/Liquibase)** |
| `jwt.secret` | cadena fija | Clave HMAC-SHA del JWT |
| `jwt.expiration` | `86400000` | Expiración del token en ms (24 h) |
| `spring.servlet.multipart.max-*` | `10MB` | Límite de subida |

## Arquitectura

Layered por **dominio funcional** (no por capa técnica). Cada dominio tiene paquetes paralelos:

```
com.example.vet
├── Model/<Dominio>       → entidades JPA
├── Controller/<Dominio>  → endpoints REST
├── Service/<Dominio>     → lógica de negocio
├── Repository/<Dominio>  → Spring Data JPA
├── Config/               → SecurityConfig, JwtFilter, JwtUtil, GlobalExceptionHandler
└── DTO/                  → objetos de request/response (solo algunos flujos)
```

Subpaquetes de dominio: `GMedica` (médico), `GVentas` (ventas/servicios), `GUsuarios` (usuarios/citas).

### Convenciones de código

- Inyección por campo `@Autowired` en controllers/services (no constructor-injection).
- Entidades con Lombok `@Data`, expuestas directamente como JSON (DTOs solo donde se documenta).
- Relaciones bidireccionales to-many usan `@JsonManagedReference` (lado propietario) / `@JsonBackReference` (inverso) para evitar recursión al serializar. No reemplazar por `@JsonIgnore` en el lado propietario (ver `Enfermedad`⇄`Especie`, `Producto`⇄`Categoria`).
- Mensajes de validación, logs y comentarios en español.
- Algunas columnas con nombre `snake_case` mapeadas vía `@JsonProperty` (ej. `imagen_url`).

## Seguridad y autenticación

Flujo:

1. `POST /api/auth/login` valida credenciales con `BCryptPasswordEncoder` y devuelve un JWT firmado con claims `subject` (correo) y `rol`.
2. El cliente envía `Authorization: Bearer <token>`.
3. `JwtFilter` valida el token, extrae correo/rol y lo coloca en el `SecurityContextHolder`.
4. `SecurityConfig` aplica las reglas de acceso.

### Matriz de acceso (`Config/SecurityConfig.java`)

| Ruta | Acceso |
|---|---|
| `/api/auth/**` | Público |
| `GET /api/servicios`, `GET /api/servicios/activos` | Público |
| `GET /api/productos` | Público |
| `POST /api/ventas`, `GET /api/ventas`, `GET /api/ventas/cliente/**`, `GET /api/pagos/**` | Autenticado |
| Cualquier otro `/api/**` | Autenticado |

> **Nota:** cualquier endpoint nuevo bajo `/api/**` queda autenticado por defecto. Para exponerlo públicamente hay que agregar su `requestMatchers` en `SecurityConfig`.
>
> **Nota:** Swagger UI (`/swagger-ui/*`) y `/v3/api-docs` no están en la lista de `permitAll`, por lo que quedan protegidos por JWT.

CORS global solo permite `http://localhost:4200`. Varios controllers anotan `@CrossOrigin(origins = "*")`; el origen efectivo lo controla la config global.

## Modelo de datos (entidades)

| Entidad | Tabla | Descripción |
|---|---|---|
| `Usuario` | `usuarios` | Credenciales (`correo`, `password` BCrypt, `estado`). Relación 1:1 con `Trabajador` o `Cliente`; M:N con `Rol` (`usuarios_roles`) |
| `Rol` | `roles` | Roles (`ROLE_USER`, etc.) |
| `Cliente` | `clientes` | Dueño de mascotas. 1:N `Mascota`; 1:1 `Usuario` |
| `Trabajador` | `trabajadores` | Personal. Enums `cargoTrabajador`, `estadoTrabajador`; M:N con `Servicio` vía `TrabajadorServicio` |
| `TrabajadorServicio` | `trabajador_servicio` | Relación trabajador↔servicio |
| `Horario` | `horarios` | Horarios por `trabajadorId`, `DayOfWeek`, hora inicio/fin |
| `Cita` | `citas` | Cita con `fechaHora`, `motivo`, enum `EstadoCita` (PENDIENTE, CONFIRMADA, REALIZADA, CANCELADA). Mascota + Servicio + Trabajador |
| `Mascota` | `mascotas` | Paciente del cliente. 1:N `HistorialClinico`, 1:N `Cita` |
| `Especie` | `especies` | Catálogo de especies; M:N con `Enfermedad` (`especie_enfermedad`) |
| `Enfermedad` | `enfermedades` | Enfermedad con `gravedad`; M:N con `Especie` |
| `HistorialClinico` | `historial_clinico` | Registro por mascota (diagnóstico, tratamiento, peso) |
| `VacunaCatalogo` | `vacunas` | Catálogo de vacunas (nombre, fabricante, enfermedad, dosis, precio) |
| `HistorialVacunacion` | `historial_vacunacion` | Aplicación de vacuna a una mascota; `documento_clinico` tipo JSON |
| `Producto` | `productos` | Producto de venta (`precio`, `stock`); M:N con `Categoria` (`producto_categoria`) |
| `Categoria` | `categorias` | Categorías de producto; M:N con `Producto` |
| `Servicio` | `servicios` | Servicio ofrecido (`precio`, `icono`, enum `EstadoServicio`) |
| `Venta` | `ventas` | Cabecera de venta (cliente, `total`, `estado`); `fecha` auto-set por `@PrePersist` |
| `DetalleVenta` | `detalle_ventas` | Línea de venta (producto opcional, `precioUnitario`, `cantidad`, `subtotal`) |

## API REST

### Autenticación — `/api/auth`

| Método | Ruta | Acceso | Descripción |
|---|---|---|---|
| POST | `/api/auth/login` | Público | Login; devuelve JWT |
| POST | `/api/auth/registro/cliente` | Público | Registro de cliente |

### Usuarios

| Método | Ruta | Acceso | Descripción |
|---|---|---|---|
| GET | `/api/usuarios/{correo}` | Autenticado | Buscar usuario por correo |
| POST | `/api/usuarios/registro` | Autenticado | Registrar usuario |
| GET | `/api/trabajadores` | Autenticado | Listar trabajadores |
| POST | `/api/trabajadores` | Autenticado | Crear trabajador (DTO `TrabajadorRequestDTO`) |
| PUT | `/api/trabajadores/{id}` | Autenticado | Actualizar trabajador |
| GET | `/api/trabajador-servicio/por-servicio/{servicioId}` | Autenticado | Trabajadores que ofrecen un servicio |
| GET | `/api/horarios/trabajador/{id}` | Autenticado | Horarios de un trabajador |
| POST | `/api/horarios` | Autenticado | Asignar horario |
| PUT | `/api/horarios/{id}` | Autenticado | Actualizar horario |
| DELETE | `/api/horarios/{id}` | Autenticado | Eliminar horario |

### Clientes y citas

| Método | Ruta | Acceso | Descripción |
|---|---|---|---|
| GET | `/api/clientes` | Autenticado | Listar clientes con contador de mascotas (`ClienteDTO`) |
| GET | `/api/clientes/{id}` | Autenticado | Cliente por id |
| POST | `/api/clientes/crearCliente` | Autenticado | Crear cliente |
| GET | `/api/citas` | Autenticado | Listar citas (`CitaDTO`) |
| POST | `/api/citas` | Autenticado | Crear cita (`CitaRequestDTO`) |
| GET | `/api/citas/dashboard` | Autenticado | Dashboard (citas hoy, ventas mes, totales) |
| GET | `/api/citas/cliente/{clienteId}` | Autenticado | Citas de un cliente |
| PATCH | `/api/citas/{id}/cancelar` | Autenticado | Cancelar cita |
| PATCH | `/api/citas/{id}/estado?estado=...` | Autenticado | Cambiar estado de cita |
| GET | `/api/citas/trabajadores-disponibles?servicioId=&fechaHora=` | Autenticado | Trabajadores libres en fecha/hora |
| GET | `/api/citas/mascotas/cliente/{clienteId}` | Autenticado | Mascotas de un cliente |

### Médico — `/api`

| Método | Ruta | Acceso | Descripción |
|---|---|---|---|
| GET/POST | `/api/mascotas` | Autenticado | Listar / crear mascotas |
| GET/PUT/DELETE | `/api/mascotas/{id}` | Autenticado | Obtener / actualizar / eliminar mascota |
| GET | `/api/especies` | Autenticado | Listar especies (`EspecieDTO`) |
| GET/POST | `/api/enfermedades` | Autenticado | Listar / crear enfermedades |
| GET/PUT/DELETE | `/api/enfermedades/{id}` | Autenticado | Obtener / actualizar / eliminar enfermedad |
| GET | `/api/vacunas/catalogo` | Autenticado | Catálogo de vacunas |
| POST | `/api/vacunas/guardar` | Autenticado | Guardar vacuna del catálogo |
| PUT/DELETE | `/api/vacunas/{id}` | Autenticado | Actualizar / eliminar vacuna |
| POST | `/api/vacunas/aplicar` | Autenticado | Registrar aplicación de vacuna |
| GET | `/api/vacunas/mascota/{mascotaId}` | Autenticado | Vacunas aplicadas a una mascota |
| POST | `/api/historial-clinico` | Autenticado | Registrar entrada de historial |
| GET | `/api/historial-clinico/mascota/{mascotaId}` | Autenticado | Historial de una mascota |

### Ventas y servicios

| Método | Ruta | Acceso | Descripción |
|---|---|---|---|
| GET | `/api/servicios` | Público | Listar servicios |
| GET | `/api/servicios/activos` | Público | Listar solo activos |
| POST | `/api/servicios` | Autenticado | Crear servicio (`ServicioRequestDTO`) |
| PUT | `/api/servicios/{id}` | Autenticado | Actualizar servicio |
| GET | `/api/productos` | Público | Listar productos (incluye `categorias`) |
| POST | `/api/productos` | Autenticado | Crear producto |
| PUT/DELETE | `/api/productos/{id}` | Autenticado | Actualizar / eliminar producto |
| GET | `/api/categorias` | Autenticado | Listar categorías |
| POST | `/api/categorias` | Autenticado | Crear categoría |
| PUT/DELETE | `/api/categorias/{id}` | Autenticado | Actualizar / eliminar categoría |
| POST | `/api/ventas` | Autenticado | Realizar venta (`VentaRequestDTO`) |
| GET | `/api/ventas` | Autenticado | Listar ventas |
| GET | `/api/ventas/cliente/{clienteId}` | Autenticado | Ventas de un cliente |
| GET | `/api/pagos/resumen` | Autenticado | Resumen de ingresos (citas + productos, últimos 6 meses) |

## Flujos de negocio clave

### Registro y login de cliente (`AuthService`)
- `registrarCliente`: valida que correo y DNI no existan, crea `Cliente` (nombres en mayúsculas) + `Usuario` con password BCrypt y rol `ROLE_USER`.
- `login`: busca usuario por correo, valida password, toma el primer rol y devuelve `LoginResponse` con token, rol, ids de trabajador/cliente y nombre.

### Creación de cita (`CitaService.crearCita`)
Valida en orden: mascota existente → servicio existente y `ACTIVO` → trabajador existente y `ACTIVO` → que el trabajador ofrezca el servicio (`TrabajadorServicio`) → guarda con estado `PENDIENTE`. `trabajadoresDisponibles` descarta trabajadores con cita no cancelada en la franja de 1 hora.

### Venta con detalles (`VentaService.realizarVentaDTO`)
Recibe `VentaRequestDTO` (clienteId + detalles), calcula `subtotal = precioUnitario * cantidad` por línea y `total` como suma; estado inicial `COMPLETADA`; `fecha` se setea en `@PrePersist`.

### Reportes
- `CitaService.getDashboard` → `DashboardDTO` (citas hoy, ventas del mes por citas `REALIZADA`, clientes y mascotas activos).
- `PagosService.getResumen` → `PagosResumenDTO` (ingresos por citas realizadas + ventas completadas, totales del mes y desglose de los últimos 6 meses para gráfico).

## Payloads de ejemplo

### Login
```json
POST /api/auth/login
{ "correo": "admin@vet.com", "password": "123456" }
```
Respuesta:
```json
{
  "token": "eyJhbGciOi...",
  "correo": "admin@vet.com",
  "rol": "ROLE_ADMIN",
  "trabajadorId": 1,
  "nombre": "Juan Perez",
  "clienteId": null
}
```

### Registro de cliente
```json
POST /api/auth/registro/cliente
{
  "nombres": "Maria",
  "apellidos": "Lopez",
  "dni": "12345678",
  "telefono": "987654321",
  "direccion": "Av. Siempre Viva 123",
  "correo": "maria@mail.com",
  "password": "secreto123"
}
```

### Crear cita
```json
POST /api/citas
{
  "mascotaId": 1,
  "servicioId": 2,
  "trabajadorId": 1,
  "fechaHora": "2026-08-20T10:00:00",
  "motivo": "Control anual"
}
```

### Realizar venta
```json
POST /api/ventas
{
  "clienteId": 1,
  "detalles": [
    { "productoId": 1, "nombreProducto": "Shampoo Medicado", "precioUnitario": 45.0, "cantidad": 2 }
  ]
}
```

### Producto con múltiples categorías
```json
POST /api/productos
{
  "nombre": "Antipulgas",
  "descripcion": "Tratamiento tópico",
  "precio": 35.0,
  "stock": 100,
  "categorias": [ { "id": 1 }, { "id": 3 } ]
}
```

## Manejo de errores

- `Config/GlobalExceptionHandler.java`: cualquier `RuntimeException` lanzada en un endpoint responde `400 Bad Request` con el mensaje (ej. "El correo ya está registrado").
- Bean Validation (`@Valid`, `@NotBlank`, `@Size`, `@Email`, `@Pattern`) devuelve errores de validación con mensajes en español definidos en las entidades/DTOs.

## Datos de prueba

`scriptVet.sql` contiene data de prueba manual (inserciones de vacunas, productos, etc.) y queries de verificación. **No se ejecuta en el build**; solo es referencia para poblar la BD manualmente.

## Tests

Únicamente `VetApplicationTests` (carga de contexto). Ejecutar con:

```bash
.\mvnw.cmd test
```

## Gotchas técnicos

- El esquema de BD lo genera Hibernate (`ddl-auto=update`) al arrancar contra MySQL local. No hay migraciones versionadas; un cambio de entidad altera el esquema automáticamente.
- Las credenciales de BD y el secreto JWT están hardcodeados; `spring-dotenv` y `.env` (ignorado) existen pero **no** se usan en la configuración actual.
- El frontend espera algunos campos en `snake_case` (ej. `imagen_url`), mapeados con `@JsonProperty`.
- `JwtFilter` imprime logs de depuración con `System.out.println` en cada request.
- Swagger UI y `/v3/api-docs` quedan protegidos por JWT (no están en `permitAll`).
- El historial git muestra intentos previos de deploy (Dockerfile para Render, PostgreSQL/Supabase, variables de entorno), todos revertidos; el estado actual es MySQL local.