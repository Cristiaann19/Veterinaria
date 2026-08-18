# Huellitas Vet — Frontend (Veta)

SPA de administración para la clínica veterinaria **Huellitas Vet**, construida con Angular. Incluye
landing pública, catálogo de productos con carrito, agendamiento de citas para clientes y un panel de
administración completo (citas, clientes, mascotas, productos, ventas, servicios, etc.).

> Backend: API REST en Spring Boot. Todas las URLs apuntan a `http://localhost:8080/api/...`
> (hardcodeadas en cada servicio, no hay archivos de entorno ni proxy de dev).

## Stack tecnológico

| Capa | Tecnología | Detalle |
|---|---|---|
| Framework | Angular **21** | Standalone components (sin `NgModule`) |
| Lenguaje | TypeScript `~5.9` | Strict mode |
| UI | PrimeNG `^21` + PrimeIcons 7 | Tema **Aura** (`@primeuix/themes`) |
| CSS | Tailwind CSS **v4** | Via `@tailwindcss/postcss`, sin `tailwind.config.js` |
| Build | Angular CLI 21 (`@angular/build`) | esbuild + Vite |
| Tests | Vitest `^4` + jsdom | Via el builder `@angular/build:unit-test` |
| Package manager | npm `11.7` | Declarado en `packageManager` |

## Requisitos previos

- Node.js con npm ≥ 11 (el repo declara `packageManager: "npm@11.7.0"`).
- Backend Spring Boot corriendo en `http://localhost:8080` (los datos cargan de forma silenciosa si está caído).

## Instalación y ejecución

```bash
npm install
npm start            # dev server → http://localhost:4200 (HMR activo)
npm run watch        # build de watch (config development)
npx ng build --configuration development   # build dev de verificación
```

## Scripts

| Script | Comando | Uso |
|---|---|---|
| `start` | `ng serve` | Dev server con recarga automática |
| `build` | `ng build` | **Producción — falla** por budget (ver más abajo) |
| `watch` | `ng build --watch --configuration development` | Build continuo |
| `test` | `ng test` | Vitest en watch; one-shot: `npm test -- --watch=false` |

### ⚠️ Build de producción

`npm run build` (producción) **falla siempre** con un error de budget preexistente:

> Budget 1.00 MB was not met by 580.26 kB with a total of 1.58 MB.

El bundle inicial supera el `maximumError: 1MB` definido en `angular.json` (`veta:build:production.budgets`).
No es un fallo causado por cambios en el código. **Para verificar tus cambios usa
`npx ng build --configuration development`.**

## Testing

- Los specs viven junto a su código (`*.spec.ts`); `tsconfig.spec.json` habilita `vitest/globals`.
- **Fallos preexistentes (no perseguir):**
  - Muchos specs "should create" de componentes fallan con `NG0201: No provider found for ActivatedRoute`
    porque el template usa `RouterLink` sin proveer el router en el test.
  - Specs que instancian servicios reales (ej. `dashboard`, `productos-page`) disparan peticiones HTTP
    reales a `http://localhost:8080` → `HttpErrorResponse: 0 Unknown Error` cuando el backend está caído.
- **Validación recomendada:** el build dev, no el test run.

## Arquitectura

### Bootstrap y configuración

- `src/main.ts` → `bootstrapApplication(App, appConfig)`.
- `src/app/app.config.ts`:
  - `provideRouter(routes, withInMemoryScrolling({ anchorScrolling, scrollPositionRestoration }))`
  - `provideHttpClient(withFetch(), withInterceptors([authInterceptor]))`
  - `providePrimeNG({ theme: { preset: Aura, options: { darkModeSelector: 'false' } } })` → tema forzado en claro.
  - `MessageService` (PrimeNG) global.

### Rutas (`src/app/app.routes.ts`)

**Público** (sin guard):
| Ruta | Componente |
|---|---|
| `/` y `/inicio` | `Inicio` (landing) |
| `/ver-productos` | `ProductosPage` (catálogo) |
| `/login` | `Login` |

**Cliente** (guard `clienteGuard` — solo requiere sesión):
| Ruta | Componente |
|---|---|
| `/agendar-cita` | `AgendarCita` |
| `/mis-citas` | `MisCitas` |
| `/mis-mascotas` | `MisMascotas` |
| `/mis-compras` | `MisCompras` |

**Admin** (guard `authGuard` — sesión + rol distinto de `ROLE_USER`): `/admin` con shell `Layout` y rutas
hijas `dashboard`, `clientes`, `mascotas`, `vacunas`, `pagos`, `horarios`, `enfermedades`, `trabajadores`,
`productos`, `ventas`, `citas`, `servicios`.

### Estructura de directorios

```
src/
├─ main.ts / styles.css
├─ app/
│  ├─ app.ts / app.config.ts / app.routes.ts
│  ├─ components/
│  │  ├─ login/                    # Login + registro de cliente
│  │  ├─ inicio/                   # ÁREA PÚBLICA
│  │  │  ├─ inicio/                # Landing: navbar + hero + sections + carrito
│  │  │  ├─ hero-section/          # Hero principal
│  │  │  ├─ sections/              # sections.ts compone: about, services, reviews,
│  │  │  │                         #   faq, contact, footer
│  │  │  ├─ productos-page/        # Catálogo /ver-productos (filtros + paginación)
│  │  │  ├─ carrito/               # Botón flotante + panel de carrito
│  │  │  └─ agendar-cita, mis-citas, mis-mascotas, mis-compras, navbar-component
│  │  └─ layout/                   # ÁREA ADMIN (shell + páginas CRUD)
│  ├─ models/                      # Interfaces del dominio (cliente, mascota, cita,
│  │                               #   producto, servicios, trabajador, vacuna, ...)
│  └─ services/                    # Auth, guards, interceptor, GToast, CarritoService
│                                  #   y un servicio HTTP por recurso
```

### Autenticación y roles

- `AuthService.login()` → `POST /api/auth/login`; `guardarSesion()` persiste `token`, `correo`, `rol`,
  `nombre`, `clienteId`/`trabajadorId` en `localStorage`.
- `authInterceptor` (functional interceptor) añade `Authorization: Bearer <token>` si existe en storage.
- Roles: `ROLE_ADMIN` / `ROLE_VET` → `/admin/dashboard`; `ROLE_USER` (cliente) → landing.
- Registro de cliente: `POST /api/auth/registro/cliente` (en `login.ts`).

### Servicios y endpoints (base `http://localhost:8080/api`)

| Servicio | Endpoints |
|---|---|
| `auth.service` | `POST /auth/login` |
| `productos` | `GET/POST /productos` · `GET/PUT/DELETE /productos/{id}` |
| `servicios` | `GET /servicios/activos` · `GET /servicios` |
| `citas-service` | `GET/POST /citas` · `GET /citas/cliente/{id}` · `PATCH /citas/{id}/cancelar` · `PATCH /citas/{id}/estado?estado=` · `GET /citas/trabajadores-disponibles` · `GET /citas/mascotas/cliente/{id}` |
| `cliente-service` | `GET/POST /clientes` · `PUT/DELETE /clientes/{id}` |
| `mascotas-service` | `GET/POST /mascotas` · `GET /mascotas/cliente/{id}` · `PUT/DELETE /mascotas/{id}` |
| `vacuna` | `GET /vacunas/catalogo` · `POST /vacunas/guardar` · `GET/PUT/DELETE /vacunas/{id}` |
| `enfermedades-service` | `GET/POST /enfermedades` · `PUT/DELETE /enfermedades/{id}` |
| `horario-service` | `GET /horarios/trabajador/{id}` · `POST/PUT/DELETE /horarios[/{id}]` |
| `trabajador-service` | `GET /trabajadores` · `DELETE /trabajadores/{id}` |
| `pagos-service` | `GET /pagos/resumen` |
| `venta-service` | `POST /ventas` · `GET /ventas` · `GET /ventas/cliente/{id}` |
| `dashboard.ts` (directo) | `GET /citas/dashboard` |

### Estado compartido y utilidades

- `CarritoService`: carrito en memoria con `BehaviorSubject<ItemCarrito[]>`; expone `items$`, `total`,
  `cantidad` y `agregar/incrementar/decrementar/eliminar/limpiar`.
- `GToast`: sistema de notificaciones propio (sin PrimeNG Toast); `success/error/warn/info/contrast`.

## Estilos y tema

- **Tailwind v4** vía `@tailwindcss/postcss` (`.postcssrc.json`) + `tailwindcss-primeui` (importado en `styles.css`).
- Tokens en el bloque `@theme` de `src/styles.css`:
  `--color-blue-primary: #004DD1`, `--color-emerald-primary: #10b981`, `--font-sans`/`--font-display` = Inter, `--font-mono` = JetBrains Mono.
- Base layer: `h1-h4 { font-family: var(--font-display) }`; global `* { font-family: 'Inter' }`.
- Títulos de secciones de la landing: `text-5xl md:text-7xl !font-display font-bold`.
- Iconos de UI: clase `material-symbols-outlined`; PrimeNG usa PrimeIcons.
- Estilos globales: scrollbar de la landing (`.dark-scroll`) y página activa del paginador (`.p-paginator .p-highlight`).

## Limitaciones y gotchas conocidas

- **Sin variables de entorno**: la base del backend (`http://localhost:8080/api`) está hardcodeada en cada
  archivo de `src/app/services/*` y en `login.ts`/`dashboard.ts`. Cambiarla requiere tocar cada servicio.
- **Build producción falla** por el budget de 1 MB (bundle ≈1.58 MB). Usar `--configuration development`.
- **Tests con fallos preexistentes** (ActivatedRoute / HTTP real); no indican regresiones.
- **Sin lint** configurado. Prettier: config en `package.json` (single quotes, printWidth 100, parser Angular para HTML).