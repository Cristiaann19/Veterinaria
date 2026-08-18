// services/mascotas-service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Mascota } from '../models/mascota';

@Injectable({ providedIn: 'root' })
export class MascotasService {
  private url = 'http://localhost:8080/api/mascotas';

  constructor(private http: HttpClient) {}

  listarMascotas(): Observable<Mascota[]> {
    return this.http.get<Mascota[]>(this.url);
  }

  listarPorCliente(clienteId: number): Observable<Mascota[]> {
    return this.http.get<Mascota[]>(`${this.url}/cliente/${clienteId}`);
  }

  crearMascota(mascota: Mascota): Observable<Mascota> {
    return this.http.post<Mascota>(this.url, mascota);
  }

  actualizarMascota(mascota: Mascota): Observable<Mascota> {
    return this.http.put<Mascota>(`${this.url}/${mascota.id}`, mascota);
  }

  eliminarMascota(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`);
  }
}

