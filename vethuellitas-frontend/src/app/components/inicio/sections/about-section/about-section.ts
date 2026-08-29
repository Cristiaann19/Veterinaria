import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfiguracionService } from '../../../../services/configuracion-service';
import { Configuracion } from '../../../../models/configuracion';

@Component({
  selector: 'app-about-section',
  imports: [CommonModule],
  templateUrl: './about-section.html',
  styleUrl: './about-section.css',
})
export class AboutSection implements OnInit {
  config: Partial<Configuracion> = {};
  defaultAboutImage = 'https://facultades.unab.cl/cienciasdelavida/wp-content/uploads/2022/02/Medicina-Veterinaria.webp';

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

  get aboutImage(): string {
    return this.config.aboutImageUrl || this.defaultAboutImage;
  }

  get siteName(): string {
    return this.config.siteName || 'Huellitas Vet';
  }
}
