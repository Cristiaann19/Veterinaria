import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ConfiguracionService } from '../../../../services/configuracion-service';
import { Configuracion } from '../../../../models/configuracion';

@Component({
  selector: 'app-contact-section',
  imports: [FormsModule, CommonModule],
  templateUrl: './contact-section.html',
  styleUrl: './contact-section.css',
})
export class ContactSection implements OnInit {
  form = {
    nombre: '',
    email: '',
    asunto: '',
    mensaje: ''
  };

  config: Partial<Configuracion> = {};

  constructor(
    private configService: ConfiguracionService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.configService.obtener().subscribe({
      next: (data) => {
        this.config = data;
        this.cdr.detectChanges();
      }
    });
  }

  get contactoEmail(): string {
    return this.config.correo || 'cristianJ@huellitasvet.com';
  }

  get contactoTelefono(): string {
    return this.config.telefono || '+51 999 999 999';
  }

  enviar(): void {
    if (!this.form.nombre || !this.form.email || !this.form.mensaje) {
      alert('Por favor completa los campos obligatorios.');
      return;
    }
    console.log('Formulario enviado:', this.form);
    alert('¡Mensaje enviado! Nos pondremos en contacto pronto.');
    this.form = { nombre: '', email: '', asunto: '', mensaje: '' };
  }
}
