import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Servicio } from '../models/servicios';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ServiciosService {
  private apiUrl = 'http://localhost:8080/api/servicios';

  constructor(private http: HttpClient) { }

  listarActivos() {
    return this.http.get<Servicio[]>(`${this.apiUrl}/activos`);
  }

  listar() {
    return this.http.get<Servicio[]>(`${this.apiUrl}`);
  }

}
