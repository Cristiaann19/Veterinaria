import { Component, HostListener, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { AuthService } from '../../../services/auth.service';
import { ConfiguracionService } from '../../../services/configuracion-service';
import { Configuracion } from '../../../models/configuracion';

@Component({
  selector: 'app-navbar-component',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './navbar-component.html',
  styleUrl: 'navbar-component.css'
})
export class NavbarComponent implements OnInit {
  isScrolled = false;
  isLoggedIn = false;
  nombre = '';
  inicial = '';
  menuPerfil = false;
  rol: string = '';

  config: Partial<Configuracion> = {};

  constructor(
    private authService: AuthService,
    private configService: ConfiguracionService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.isLoggedIn = this.authService.isLoggedIn();
    if (this.isLoggedIn) {
      this.rol = localStorage.getItem('rol') ?? '';
      this.nombre = localStorage.getItem('nombre') ?? '';
      this.inicial = this.nombre.charAt(0).toUpperCase();
    }
    this.configService.obtener().subscribe({
      next: (data) => {
        this.config = data;
        this.cdr.detectChanges();
      }
    });
  }

  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.isScrolled = window.scrollY > 50;
  }

  toggleMenuPerfil(): void {
    this.menuPerfil = !this.menuPerfil;
  }

  cerrarSesion(): void {
    this.authService.logout();
    this.isLoggedIn = false;
    this.menuPerfil = false;
  }

  get siteName(): string {
    return this.config.siteName || 'Huellitas';
  }

  get logoUrl(): string {
    return this.config.logoUrl || '';
  }

  get esCliente(): boolean {
    return this.rol === 'ROLE_USER';
  }

  get esPersonal(): boolean {
    return this.rol === 'ROLE_ADMIN' || this.rol === 'ROLE_VET';
  }
}
