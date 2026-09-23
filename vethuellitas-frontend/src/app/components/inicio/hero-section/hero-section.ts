import { Component, HostListener, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ConfiguracionService } from '../../../services/configuracion-service';
import { Configuracion } from '../../../models/configuracion';

@Component({
  selector: 'app-hero-section',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './hero-section.html',
  styleUrls: ['./hero-section.css']
})
export class HeroSection implements OnInit {
  scrollOpacity = 1;
  imageScale = 1;
  textY = 0;

  config: Partial<Configuracion> = {};
  defaultVideoUrl = 'https://res.cloudinary.com/ddxdadxtr/video/upload/v1788636529/peluche_sohgi5.webm';

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

  get videoUrl(): string {
    return this.config.heroVideoUrl || this.defaultVideoUrl;
  }

  get isWebm(): boolean {
    return this.videoUrl.endsWith('.webm');
  }

  @HostListener('window:scroll', [])
  onWindowScroll() {
    const scroll = window.scrollY;
    const height = window.innerHeight;
    const progress = Math.min(scroll / height, 1);
    this.imageScale = 1 + (progress * 0.2);
    this.scrollOpacity = Math.max(1 - (progress * 2), 0);
    this.textY = progress * -200;
  }
}
