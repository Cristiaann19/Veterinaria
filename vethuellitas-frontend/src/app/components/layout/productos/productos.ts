import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Producto } from '../../../models/producto';
import { ProductoService } from '../../../services/productos';
import { UploadService } from '../../../services/upload-service';
import { GToast } from '../../../services/gtoast';
// PrimeNG
import { DialogModule } from 'primeng/dialog';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { PaginatorModule } from 'primeng/paginator';

@Component({
  selector: 'app-productos',
  standalone: true,
  imports: [CommonModule, FormsModule, DialogModule, ButtonModule, InputTextModule, PaginatorModule],
  templateUrl: './productos.html',
})
export class Productos implements OnInit {
  productos: Producto[] = [];
  productosFiltrados: Producto[] = [];
  productosMostrados: Producto[] = [];

  terminoBusqueda: string = '';

  displayEdit: boolean = false;
  displayDelete: boolean = false;
  displayNew: boolean = false;

  selectedProducto: Producto = {} as Producto;

  first: number = 0;
  rows: number = 8;

  subiendoImagen: boolean = false;

  constructor(
    private productoService: ProductoService,
    private uploadService: UploadService,
    private cdr: ChangeDetectorRef,
    private toast: GToast
  ) {}

  ngOnInit(): void {
    this.cargarProductos();
  }

  cargarProductos(): void {
    this.productoService.listarProductos().subscribe({
      next: (data) => {
        this.productos = data;
        this.filtrar();
        this.cdr.detectChanges();
      }
    });
  }

  filtrar(): void {
    this.productosFiltrados = this.productos.filter(p =>
      p.nombre.toLowerCase().includes(this.terminoBusqueda.toLowerCase())
    );
    this.first = 0;
    this.actualizarVista();
  }

  actualizarVista(): void {
    this.productosMostrados = this.productosFiltrados.slice(this.first, this.first + this.rows);
  }

  onPageChange(event: any): void {
    this.first = event.first;
    this.actualizarVista();
  }

  abrirEditar(producto: Producto): void {
    this.selectedProducto = { ...producto };
    this.displayEdit = true;
  }

  confirmarEliminar(producto: Producto): void {
    this.selectedProducto = producto;
    this.displayDelete = true;
  }

  abrirNuevo(): void {
    this.selectedProducto = { nombre: '', precio: 0, stock: 0, descripcion: '', imagen_url: '', categorias: [] } as Producto;
    this.displayNew = true;
  }

  eliminarProducto(): void {
    this.productoService.eliminarProducto(this.selectedProducto.id!).subscribe(() => {
      this.toast.success('Producto Eliminado');
      setTimeout(() => {
        this.cargarProductos();
        this.displayDelete = false;
        this.cdr.detectChanges();
      }, 0);
    });
  }

  guardarCambios(): void {
    this.productoService.actualizarProducto(this.selectedProducto).subscribe({
      next: () => {
        this.toast.success('Producto actualizado');
        setTimeout(() => {
          this.displayEdit = false;
          this.cargarProductos();
          this.cdr.detectChanges();
        }, 0);
      },
      error: (err) => console.error('Error al guardar:', err)
    });
  }

  guardarNuevo(): void {
    this.productoService.crearProducto(this.selectedProducto).subscribe({
      next: () => {
        this.toast.success('Producto guardado');
        setTimeout(() => {
          this.displayNew = false;
          this.cargarProductos();
          this.cdr.detectChanges();
        }, 0);
      },
      error: (err) => console.error('Error al guardar:', err)
    });
  }

  onFileSelected(event: Event, destino: 'nuevo' | 'editar'): void {
    const input = event.target as HTMLInputElement;
    if (!input.files || input.files.length === 0) return;

    const archivo = input.files[0];
    this.subiendoImagen = true;

    this.uploadService.subir(archivo).subscribe({
      next: (res) => {
        this.selectedProducto.imagen_url = res.url;
        this.subiendoImagen = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.toast.error('Error al subir imagen');
        this.subiendoImagen = false;
        this.cdr.detectChanges();
      }
    });
  }
}
