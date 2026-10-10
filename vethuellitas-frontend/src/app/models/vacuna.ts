import { Enfermedad } from "./enfermedad";

export interface Vacuna {
    id: number;
    nombre: string;
    fabricante: string;
    enfermedades: Enfermedad[];
    edadRecomendada: number;
    dosis: number;
    precio: number;
}
