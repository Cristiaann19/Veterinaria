# 🐾 Veterinaria Huellitas — Sistema de Gestión para Clínica Veterinaria

Sistema web desarrollado para digitalizar y agilizar la gestión integral de la clínica veterinaria **Huellitas**. Reemplaza el control manual de clientes, mascotas, citas, ventas, vacunas e historial clínico por un flujo automatizado con panel de administración, catálogo de productos y reportes de pagos en tiempo real.

![Estado](https://img.shields.io/badge/estado-en%20desarrollo-yellow)
![Backend](https://img.shields.io/badge/backend-Spring%20Boot-6DB33F?logo=springboot&logoColor=white)
![Frontend](https://img.shields.io/badge/frontend-Angular-DD0031?logo=angular&logoColor=white)
![DB](https://img.shields.io/badge/base%20de%20datos-MySQL-4479A1?logo=mysql&logoColor=white)
![Licencia](https://img.shields.io/badge/licencia-académica-lightgrey)

---

## 📑 Tabla de contenidos

- [Sobre el proyecto](#-sobre-el-proyecto)
- [Características principales](#-características-principales)
- [Fuera de alcance](#-fuera-de-alcance)
- [Arquitectura](#️-arquitectura)
- [Stack tecnológico](#️-stack-tecnológico)
- [Estructura del repositorio](#-estructura-del-repositorio)
- [Requisitos previos](#-requisitos-previos)
- [Instalación y ejecución local](#-instalación-y-ejecución-local)
- [Flujo de trabajo con Git (GitHub Flow)](#-flujo-de-trabajo-con-git-github-flow)
- [Seguridad y autenticación](#-seguridad-y-autenticación)
- [Infraestructura y despliegue](#️-infraestructura-y-despliegue)
- [Gestión del proyecto](#-gestión-del-proyecto)
- [Equipo de desarrollo](#-equipo-de-desarrollo)
- [Documentación adicional](#-documentación-adicional)
- [Licencia](#-licencia)

---

## 📖 Sobre el proyecto

La clínica veterinaria Huellitas administra sus operaciones de forma manual, lo cual genera errores en el registro de clientes y mascotas, demoras en la agendamiento de citas y dificultad para consultar historiales clínicos y reportes de ingresos. Este sistema busca:

- Digitalizar el registro de clientes, mascotas, historial clínico y vacunación.
- Automatizar la agendación de citas con verificación de disponibilidad de trabajadores.
- Gestionar ventas de productos y servicios con cálculo automático de totales.
- Consolidar reportes de ingresos (citas + productos) en tiempo real.
- Ofrecer una landing pública con catálogo de productos y agendamiento de citas para clientes.

**Objetivo general:** desarrollar e implementar un sistema web para la clínica veterinaria Huellitas que facilite la gestión de clientes, mascotas, citas, ventas, vacunas e historial clínico de forma eficiente, segura y accesible.

---

## ✨ Características principales

- 🏠 **Landing pública** con información de servicios, catálogo de productos y agendamiento de citas.
- 🛒 **Catálogo de productos** con filtros, paginación y carrito de compras.
- 📅 **Agendamiento de citas** con verificación de disponibilidad de trabajadores por fecha y hora.
- 🐕 **Registro de mascotas** con historial clínico, vacunas aplicadas y enfermedades por especie.
- 💉 **Gestión de vacunas** con catálogo de vacunas, aplicación a mascotas y registro de dosis.
- 💊 **Historial clínico** por mascota con diagnóstico, tratamiento y peso.
- 🧾 **Registro de ventas** con cálculo automático de subtotales y totales (productos + servicios).
- 💰 **Reporte de ingresos** con desglose de últimos 6 meses para gráfico.
- 📊 **Dashboard administrativo** con citas del día, ventas del mes, clientes y mascotas activos.
- 🔐 **Autenticación JWT** con roles diferenciados (Administrador, Veterinario, Cliente).
- 📱 **Acceso responsivo** desde navegadores de escritorio y dispositivos móviles.

## 🚫 Fuera de alcance

La versión actual **no** contempla:

- Pasarelas de pago en línea.
- Módulo de e-commerce externo para clientes finales.
- Integración directa de facturación electrónica.
- Sistema de laboratorio o análisis clínicos.

---

## 🏗️ Arquitectura

Veterinaria Huellitas utiliza una **arquitectura desacoplada** (cliente-servidor), con separación clara entre presentación y lógica de negocio, comunicadas vía HTTP/REST.

```
┌─────────────────────┐        HTTP/REST        ┌──────────────────────┐        JDBC        ┌─────────────┐
│   Frontend (Angular) │ ───────────────────────▶ │  Backend (Spring Boot) │ ─────────────────▶ │   MySQL     │
│  components/         │ ◀─────────────────────── │  Controller/Service/  │ ◀───────────────── │  Base de    │
│  services/ models/   │        JSON/DTO         │  Repository/Model     │                    │   datos     │
└─────────────────────┘                          └──────────────────────┘                    └─────────────┘
```

### Frontend (Angular) — Standalone Components

```
src/app/
├── components/
│   ├── login/          # Login + registro de cliente
│   ├── inicio/         # Área pública: landing, catálogo, carrito, agendar cita
│   └── layout/         # Panel administrativo: dashboard, CRUD completo
├── models/             # Interfaces TypeScript del dominio
└── services/           # Auth, guards, interceptor y servicios HTTP por recurso
```

### Backend (Spring Boot) — Arquitectura por dominio funcional

```
vethuellitas-backend/
├── src/main/java/com/example/vet/
│   ├── Model/          # Entidades JPA por dominio (GMedica, GVentas, GUsuarios)
│   ├── Controller/     # Endpoints REST
│   ├── Service/        # Lógica de negocio
│   ├── Repository/     # Interfaces Spring Data JPA
│   ├── Config/         # SecurityConfig, JwtFilter, JwtUtil
│   └── DTO/            # Objetos de request/response
├── src/main/resources/
├── scriptVet.sql       # Datos de prueba
└── pom.xml
```

---

## 🛠️ Stack tecnológico

| Capa | Tecnologías |
|---|---|
| **Frontend** | Angular 21 · TypeScript 5.9 · PrimeNG 21 · Tailwind CSS v4 · PrimeIcons 7 |
| **Backend** | Java 21 · Spring Boot 4.0.1 · Spring Security + JJWT 0.12.3 · Spring Data JPA / Hibernate · Maven |
| **Base de datos** | MySQL 8 |
| **Almacenamiento de imágenes** | Cloudinary |
| **Documentación API** | springdoc-openapi (Swagger UI) |
| **Control de versiones** | Git + GitHub (GitHub Flow) |
| **Gestión y planificación** | ClickUp |
| **Diseño y prototipado** | Draw.io |
| **Frontend (despliegue)** | Vercel |
| **Backend (próximamente)** | Microsoft Azure / AWS |
| **IDEs recomendados** | Visual Studio Code · IntelliJ IDEA · WebStorm |

---

## 📂 Estructura del repositorio

```
Veterinaria/
├── vethuellitas-backend/    # API REST en Spring Boot
│   ├── src/
│   ├── scriptVet.sql        # Datos de prueba
│   ├── BackupVet.sql        # Backup de la base de datos
│   └── pom.xml
├── vethuellitas-frontend/   # SPA en Angular
│   ├── src/
│   ├── angular.json
│   └── package.json
└── README.md
```

---

## ✅ Requisitos previos

- **Java** 21 o superior
- **Node.js** (LTS ≥ 11) y **npm**
- **Angular CLI** (`npm install -g @angular/cli`)
- **MySQL** 8 (local o accesible remotamente)
- **Git**

---

## 🚀 Instalación y ejecución local

### 1. Clonar el repositorio

```bash
git clone https://github.com/Cristiaann19/Veterinaria.git
cd Veterinaria
```

### 2. Configurar la base de datos

```bash
# Crear la base de datos
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS veterinaria_web"

# O importar el backup incluido
mysql -u root -p veterinaria_web < vethuellitas-backend/BackupVet.sql
```

Actualiza las credenciales de conexión en `vethuellitas-backend/src/main/resources/application.properties` (usuario, contraseña, URL).

### 3. Levantar el Backend (Spring Boot)

```bash
cd vethuellitas-backend
# Windows
.\mvnw.cmd spring-boot:run

# Linux/Mac
./mvnw spring-boot:run
```

El servidor se expone por defecto en `http://localhost:8080`.

### 4. Levantar el Frontend (Angular)

```bash
cd vethuellitas-frontend
npm install
npm start
```

La aplicación estará disponible en `http://localhost:4200`.

### 5. Iniciar sesión

Ingresa con las credenciales configuradas en la base de datos para acceder al panel de administración (dashboard, clientes, mascotas, citas, ventas, productos, servicios, vacunas, historial clínico, reportes).

---

## 🌿 Flujo de trabajo con Git (GitHub Flow)

El proyecto trabaja bajo el modelo **GitHub Flow**: la rama `main` siempre se mantiene estable y lista para producción.

- **`main`** → código de producción.
- **`feature/...`** → rama por funcionalidad.
- **`fix/...`** → ramas dedicadas a la corrección de errores.

**Reglas de integración:**

1. Todo cambio se desarrolla en una rama secundaria, nunca directo en `main`.
2. Se abre un **Pull Request** por cada rama a integrar.
3. La fusión se realiza manteniendo un historial lineal.
4. Los commits siguen el estándar **Conventional Commits**:

   ```
   <tipo>(<ámbito opcional>): <descripción breve>
   ```

   | Tipo | Uso |
   |---|---|
   | `feat` | Nueva funcionalidad |
   | `fix` | Corrección de errores |
   | `docs` | Cambios de documentación |
   | `style` | Cambios de formato sin impacto en lógica |
   | `refactor` | Reestructuración sin corregir errores ni añadir funciones |
   | `test` | Pruebas nuevas o corregidas |

---

## 🔐 Seguridad y autenticación

### Flujo de autenticación

1. `POST /api/auth/login` valida credenciales con `BCryptPasswordEncoder` y devuelve un JWT firmado con claims `subject` (correo) y `rol`.
2. El cliente envía `Authorization: Bearer <token>`.
3. `JwtFilter` valida el token, extrae correo/rol y lo coloca en el `SecurityContextHolder`.
4. `SecurityConfig` aplica las reglas de acceso.

### Matriz de acceso

| Ruta | Acceso |
|---|---|
| `/api/auth/**` | Público |
| `GET /api/servicios`, `GET /api/servicios/activos` | Público |
| `GET /api/productos` | Público |
| Cualquier otro `/api/**` | Autenticado (JWT) |

### Roles

| Rol | Permisos |
|---|---|
| `ROLE_ADMIN` | Acceso total al panel administrativo |
| `ROLE_VET` | Acceso al panel administrativo |
| `ROLE_USER` | Cliente: agendar citas, ver mis mascotas, mis compras |

> **Nota:** cualquier endpoint nuevo bajo `/api/**` queda autenticado por defecto. Para exponerlo públicamente hay que agregar su `requestMatchers` en `SecurityConfig`.

---

## ☁️ Infraestructura y despliegue

| Componente | Plataforma | Estado |
|---|---|---|
| Frontend | **Vercel** | ✅ Desplegado |
| Backend | **Microsoft Azure / AWS** | 🔜 Próximamente |
| Base de datos | **MySQL** | Local (próximamente en la nube) |

---

## 📋 Gestión del proyecto

- **Diseño y prototipado de interfaces:** Draw.io (mockups de landing, login, panel administrativo).

---

## 👥 Equipo de desarrollo

| Integrante | Rol |
|---|---|
| **Cristian Jesús Huamán Cruz** | Desarrollador Fullstack |

---

## 📄 Documentación adicional

- **Swagger UI:** disponible en `http://localhost:8080/swagger-ui/*` (requiere JWT).
- **API Docs:** `http://localhost:8080/v3/api-docs` (requiere JWT).
- **README del Backend:** [vethuellitas-backend/README.md](vethuellitas-backend/README.md) — documentación técnica detallada de la API REST.
- **README del Frontend:** [vethuellitas-frontend/README.md](vethuellitas-frontend/README.md) — arquitectura, rutas, servicios y estilos del frontend.

---

## 📜 Licencia

Proyecto desarrollado con fines **académicos** para el curso de Desarrollo Web Integrado. Uso educativo, no comercial.
