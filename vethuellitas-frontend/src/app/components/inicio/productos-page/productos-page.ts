import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PaginatorModule, PaginatorState } from 'primeng/paginator';
import { NavbarComponent } from '../navbar-component/navbar-component';
import { FooterSection } from '../sections/footer-section/footer-section';
import { Carrito } from '../carrito/carrito';
import { Producto } from '../../../models/producto';
import { ProductoService } from '../../../services/productos';
import { CarritoService } from '../../../services/carrito-service';
import { GToast } from '../../../services/gtoast';

@Component({
  selector: 'app-productos-page',
  standalone: true,
  imports: [CommonModule, FormsModule, PaginatorModule, NavbarComponent, FooterSection, Carrito],
  templateUrl: './productos-page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ProductosPage implements OnInit {
  productos: Producto[] = [];

  // Búsqueda
  terminoBusqueda = '';

  // Filtro de categoría
  categoriaSeleccionada = '';

  // Paginación
  first = 0;
  rows = 8;

  cargando = true;

  constructor(
    private productoService: ProductoService,
    private carritoService: CarritoService,
    private toast: GToast,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.cargarProductos();
  }

  cargarProductos(): void {
    this.productoService.listarProductos().subscribe({
      next: (data) => {
        Promise.resolve().then(() => {
          this.productos = data;
          this.cargando = false;
          this.cdr.markForCheck();
        });
      },
      error: () => {
        this.cargando = false;
        this.cdr.markForCheck();
      }
    });
  }

  get categorias(): { nombre: string; cantidad: number }[] {
    const conteo = new Map<string, number>();
    for (const p of this.productos) {
      if (p.categoria?.trim()) {
        conteo.set(p.categoria, (conteo.get(p.categoria) ?? 0) + 1);
      }
    }
    return [...conteo.entries()]
      .map(([nombre, cantidad]) => ({ nombre, cantidad }))
      .sort((a, b) => a.nombre.localeCompare(b.nombre));
  }

  get productosFiltrados(): Producto[] {
    const t = this.terminoBusqueda.trim().toLowerCase();
    return this.productos.filter(p => {
      const coincideTexto = !t || p.nombre.toLowerCase().includes(t);
      const coincideCategoria = !this.categoriaSeleccionada || p.categoria === this.categoriaSeleccionada;
      return coincideTexto && coincideCategoria;
    });
  }

  get productosMostrados(): Producto[] {
    return this.productosFiltrados.slice(this.first, this.first + this.rows);
  }

  seleccionarCategoria(categoria: string): void {
    this.categoriaSeleccionada = categoria;
    this.first = 0;
    this.cdr.markForCheck();
  }

  onBusquedaChange(): void {
    this.first = 0;
    this.cdr.markForCheck();
  }

  onPageChange(event: PaginatorState): void {
    this.first = event.first ?? 0;
    this.cdr.markForCheck();
  }

  agregarAlCarrito(producto: Producto): void {
    this.carritoService.agregar({
      productoId: producto.id,
      nombreProducto: producto.nombre,
      precioUnitario: producto.precio,
      cantidad: 1,
      imagenUrl: producto.imagen_url
    });
    this.toast.success(`${producto.nombre} agregado al carrito`);
  }
}