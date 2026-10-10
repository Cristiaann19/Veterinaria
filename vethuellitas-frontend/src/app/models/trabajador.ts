import { Usuario } from "./usuario";

export interface Trabajador {
    id?: number;
    dni: string;
    nombres: string;
    apellidos: string;
    direccion: string;
    cargo: 'VETERINARIO' | 'ESTILISTA' | 'RECEPCIONISTA' | 'CIRUJANO';
    telefono: string;
    correo: string;
    estado: 'ACTIVO' | 'INACTIVO';
}
