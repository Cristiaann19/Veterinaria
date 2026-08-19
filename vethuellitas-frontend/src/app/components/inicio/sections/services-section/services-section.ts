import {ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit} from '@angular/core';
import { CommonModule} from '@angular/common';
import { Servicio} from '../../../../models/servicios';
import { ServiciosService} from '../../../../services/servicios';

@Component({
  selector: 'app-services-section',
  imports: [ CommonModule],
  templateUrl: './services-section.html',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class ServicesSection implements OnInit {
  servicios: Servicio[] = [];
  serviciosMostrados: Servicio[] = [];
  cargando = true;
  error = false;

  constructor(private servicioService: ServiciosService, private cdr: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.cargarServicios();
  }

  cargarServicios(): void {
    this.cargando = true;
    this.error = false;
    this.servicioService.listarActivos().subscribe({
      next: (data) => {
        this.servicios = data;
        this.serviciosMostrados = data;
        this.cargando = false;
        this.cdr.markForCheck();
      },
      error: () => {
        this.cargando = false;
        this.error = true;
        this.cdr.markForCheck();
      }
    });
  }

  reintentar(): void {
    this.cargarServicios();
  }
}
