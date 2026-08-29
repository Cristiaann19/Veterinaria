import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive, Router, NavigationEnd, ActivatedRoute } from '@angular/router';
import { filter, map } from 'rxjs/operators';
import { AuthService } from '../../services/auth.service';
import { ConfiguracionService } from '../../services/configuracion-service';
import { Configuracion } from '../../models/configuracion';

@Component({
  selector: 'app-layout',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  templateUrl: './layout.html',
})
export class Layout implements OnInit {
  titulo: string = '';
  sidebarOpen = true;

  nombre: string = '';
  correo: string = '';
  rol: string = '';
  inicial: string = '';

  config: Partial<Configuracion> = {};

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private cdr: ChangeDetectorRef,
    private authService: AuthService,
    private configService: ConfiguracionService
  ) {}

  ngOnInit(): void {
    this.actualizarTitulo();
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe(() => {
      this.actualizarTitulo();
    });
    this.correo = localStorage.getItem('correo') ?? 'Correo';
    this.rol = localStorage.getItem('rol') ?? '';
    this.nombre = localStorage.getItem('nombre') ?? this.nombre;
    this.inicial = this.correo.charAt(0).toUpperCase();

    this.configService.obtener().subscribe({
      next: (data) => {
        this.config = data;
        this.cdr.detectChanges();
      }
    });
  }

  private actualizarTitulo(): void {
    let route = this.activatedRoute.root;

    while (route.firstChild) {
      route = route.firstChild;
    }
    route.data.subscribe(data => {
      this.titulo = data['title'] || 'Panel Administrativo';
      this.cdr.detectChanges();
    });
  }

  cerrarSesion(): void {
    this.authService.logout();
  }

  PaginaWeb(): void {
    this.router.navigate(['/inicio']);
  }

  toggleSidebar() {
    this.sidebarOpen = !this.sidebarOpen;
  }

  get logoUrl(): string {
    return this.config.logoUrl || '';
  }

  get siteName(): string {
    return this.config.siteName || 'Huellitas Vet';
  }

  get rolFormateado(): string {
    const roles: Record<string, string> = {
      'ROLE_ADMIN': 'Administrador',
      'ROLE_VET': 'Veterinario',
      'ROLE_USER': 'Usuario'
    };
    return roles[this.rol] ?? this.rol.replace('ROLE_', '');
  }

  get esAdmin(): boolean {
    return this.rol === 'ROLE_ADMIN';
  }
}

