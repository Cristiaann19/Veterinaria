import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Categoria } from '../../../models/producto';
import { CategoriaService } from '../../../services/categoria-service';
import { GToast } from '../../../services/gtoast';
import { DialogModule } from 'primeng/dialog';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { TextareaModule } from 'primeng/textarea';
import { PaginatorModule } from 'primeng/paginator';
import { TableModule } from 'primeng/table';

@Component({
  selector: 'app-categorias',
  standalone: true,
  imports: [CommonModule, FormsModule, TableModule, DialogModule, ButtonModule, InputTextModule, TextareaModule, PaginatorModule],
  templateUrl: './categorias.html',
})
export class Categorias implements OnInit {
  categorias: Categoria[] = [];
  categoriasFiltradas: Categoria[] = [];
  categoriasMostradas: Categoria[] = [];

  terminoBusqueda: string = '';

  displayEdit: boolean = false;
  displayDelete: boolean = false;
  displayNew: boolean = false;

  selectedCategoria: Categoria = {} as Categoria;

  first: number = 0;
  rows: number = 8;

  constructor(
    private categoriaService: CategoriaService,
    private cdr: ChangeDetectorRef,
    private toast: GToast
  ) {}

  ngOnInit(): void {
    this.cargarCategorias();
  }

  cargarCategorias(): void {
    this.categoriaService.listar().subscribe({
      next: (data) => {
        this.categorias = data;
        this.filtrar();
        this.cdr.detectChanges();
      }
    });
  }

  filtrar(): void {
    this.categoriasFiltradas = this.categorias.filter(c =>
      c.nombre.toLowerCase().includes(this.terminoBusqueda.toLowerCase())
    );
    this.first = 0;
    this.actualizarVista();
  }

  actualizarVista(): void {
    this.categoriasMostradas = this.categoriasFiltradas.slice(this.first, this.first + this.rows);
  }

  onPageChange(event: any): void {
    this.first = event.first;
    this.actualizarVista();
  }

  abrirEditar(categoria: Categoria): void {
    this.selectedCategoria = { ...categoria };
    this.displayEdit = true;
  }

  confirmarEliminar(categoria: Categoria): void {
    this.selectedCategoria = categoria;
    this.displayDelete = true;
  }

  abrirNuevo(): void {
    this.selectedCategoria = { nombre: '', descripcion: '' } as Categoria;
    this.displayNew = true;
  }

  eliminarCategoria(): void {
    this.categoriaService.eliminar(this.selectedCategoria.id!).subscribe(() => {
      this.toast.success('Categoría eliminada');
      setTimeout(() => {
        this.cargarCategorias();
        this.displayDelete = false;
        this.cdr.detectChanges();
      }, 0);
    });
  }

  guardarCambios(): void {
    this.categoriaService.actualizar(this.selectedCategoria).subscribe({
      next: () => {
        this.toast.success('Categoría actualizada');
        setTimeout(() => {
          this.displayEdit = false;
          this.cargarCategorias();
          this.cdr.detectChanges();
        }, 0);
      },
      error: (err) => console.error('Error al guardar:', err)
    });
  }

  guardarNuevo(): void {
    this.categoriaService.crear(this.selectedCategoria).subscribe({
      next: () => {
        this.toast.success('Categoría creada');
        setTimeout(() => {
          this.displayNew = false;
          this.cargarCategorias();
          this.cdr.detectChanges();
        }, 0);
      },
      error: (err) => console.error('Error al guardar:', err)
    });
  }
}
