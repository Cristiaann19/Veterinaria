import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Configuracion } from '../../../models/configuracion';
import { ConfiguracionService } from '../../../services/configuracion-service';
import { UploadService } from '../../../services/upload-service';
import { GToast } from '../../../services/gtoast';

@Component({
  selector: 'app-configuracion',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './configuracion.html',
})
export class ConfiguracionPage implements OnInit {
  config: Configuracion = {} as Configuracion;
  cargando: boolean = true;
  subiendo: boolean = false;

  constructor(
    private configService: ConfiguracionService,
    private uploadService: UploadService,
    private cdr: ChangeDetectorRef,
    private toast: GToast
  ) {}

  ngOnInit(): void {
    this.cargarConfiguracion();
  }

  cargarConfiguracion(): void {
    this.cargando = true;
    this.configService.obtener().subscribe({
      next: (data) => {
        this.config = data;
        this.cargando = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.cargando = false;
        this.cdr.detectChanges();
      }
    });
  }

  onFileSelected(event: Event, campo: keyof Configuracion): void {
    const input = event.target as HTMLInputElement;
    if (!input.files || input.files.length === 0) return;

    const archivo = input.files[0];
    this.subiendo = true;

    this.uploadService.subir(archivo).subscribe({
      next: (res) => {
        (this.config as any)[campo] = res.url;
        this.subiendo = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.toast.error('Error al subir imagen');
        this.subiendo = false;
        this.cdr.detectChanges();
      }
    });
  }

  guardar(): void {
    this.configService.actualizar(this.config).subscribe({
      next: () => {
        this.toast.success('Configuración actualizada');
        this.cdr.detectChanges();
      },
      error: () => {
        this.toast.error('Error al guardar configuración');
      }
    });
  }
}
