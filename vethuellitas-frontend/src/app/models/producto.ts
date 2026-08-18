export interface Producto {
    id: number;
    nombre: string;
    precio: number;
    stock: number;
    descripcion: string;
    imagen_url: string;
    categorias?: Categoria[];
}

export interface Categoria {
    id: number;
    nombre: string;
    descripcion?: string;
}