import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ConfiguracionService } from '../../../../services/configuracion-service';
import { Configuracion } from '../../../../models/configuracion';

@Component({
  selector: 'app-footer-section',
  imports: [CommonModule],
  standalone: true,
  templateUrl: './footer-section.html',
})
export class FooterSection implements OnInit {
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

  get siteName(): string {
    return this.config.siteName || 'Huellitas Vet';
  }
}
