import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ClienteService } from '../../../services/cliente-service';
import { MascotasService } from '../../../services/mascotas-service';
import { CitasService } from '../../../services/citas-service';
import { VentaService } from '../../../services/venta-service';
import { Cliente } from '../../../models/cliente';
import { Mascota } from '../../../models/mascota';
import { Cita } from '../../../models/cita';
import { Venta } from '../../../models/carrito';
import { GToast } from '../../../services/gtoast';
import { FooterSection } from '../sections/footer-section/footer-section';

@Component({
  selector: 'app-perfil-page',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink, FooterSection],
  templateUrl: './perfil-page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PerfilPage implements OnInit {
  cliente: Cliente | null = null;
  clienteBackup: Cliente | null = null;

  cargando = true;
  error = false;
  editando = false;
  guardando = false;

  nombre = '';
  iniciales = '';

  mascotas: Mascota[] = [];
  citas: Cita[] = [];
  ventas: Venta[] = [];

  constructor(
    private clienteService: ClienteService,
    private mascotasService: MascotasService,
    private citaService: CitasService,
    private ventaService: VentaService,
    private toast: GToast,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.nombre = localStorage.getItem('nombre') ?? '';
    this.iniciales = this.nombre.split(' ').map(n => n.charAt(0)).join('').toUpperCase().slice(0, 2);
    this.cargarPerfil();
  }

  cargarPerfil(): void {
    this.cargando = true;
    this.error = false;
    this.editando = false;

    const clienteId = Number(localStorage.getItem('clienteId'));
    if (!clienteId) {
      this.cargando = false;
      this.error = true;
      this.cdr.markForCheck();
      return;
    }

    this.clienteService.obtenerPorId(clienteId).subscribe({
      next: (data) => {
        this.cliente = data;
        this.cargando = false;
        this.cargarResumen(clienteId);
        this.cdr.markForCheck();
      },
      error: () => {
        this.cargando = false;
        this.error = true;
        this.cdr.markForCheck();
      }
    });
  }

  cargarResumen(clienteId: number): void {
    this.mascotasService.listarPorCliente(clienteId).subscribe({
      next: (data) => { this.mascotas = data; this.cdr.markForCheck(); }
    });
    this.citaService.listarPorCliente(clienteId).subscribe({
      next: (data) => {
        this.citas = data.sort((a, b) =>
          new Date(b.fechaHora).getTime() - new Date(a.fechaHora).getTime()
        );
        this.cdr.markForCheck();
      }
    });
    this.ventaService.listarPorCliente(clienteId).subscribe({
      next: (data) => {
        this.ventas = data.sort((a, b) =>
          new Date(b.fecha).getTime() - new Date(a.fecha).getTime()
        );
        this.cdr.markForCheck();
      }
    });
  }

  editar(): void {
    this.clienteBackup = { ...this.cliente! };
    this.editando = true;
    this.cdr.markForCheck();
  }

  cancelar(): void {
    this.cliente = { ...this.clienteBackup! };
    this.clienteBackup = null;
    this.editando = false;
    this.cdr.markForCheck();
  }

  guardar(): void {
    if (!this.cliente || !this.cliente.id) return;

    if (!this.cliente.nombres?.trim() || !this.cliente.apellidos?.trim()) {
      this.toast.warn('Nombres y apellidos son obligatorios');
      return;
    }

    this.guardando = true;
    this.clienteService.actualizarCliente(this.cliente.id, this.cliente).subscribe({
      next: (actualizado) => {
        this.cliente = actualizado;
        this.editando = false;
        this.guardando = false;
        this.clienteBackup = null;
        this.nombre = `${actualizado.nombres} ${actualizado.apellidos}`;
        this.toast.success('Perfil actualizado');
        this.cdr.markForCheck();
      },
      error: () => {
        this.guardando = false;
        this.toast.error('Error al actualizar el perfil');
        this.cdr.markForCheck();
      }
    });
  }

  reintentar(): void {
    this.cargarPerfil();
  }

  get proximasCitas(): number {
    return this.citas.filter(c =>
      (c.estado === 'PENDIENTE' || c.estado === 'CONFIRMADA') &&
      new Date(c.fechaHora) > new Date()
    ).length;
  }

  get totalGastado(): number {
    return this.ventas.reduce((acc, v) => acc + v.total, 0);
  }
}
