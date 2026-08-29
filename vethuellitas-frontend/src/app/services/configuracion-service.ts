import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Configuracion } from '../models/configuracion';

@Injectable({ providedIn: 'root' })
export class ConfiguracionService {
  private apiUrl = 'http://localhost:8080/api/configuracion';

  constructor(private http: HttpClient) {}

  obtener(): Observable<Configuracion> {
    return this.http.get<Configuracion>(this.apiUrl);
  }

  actualizar(config: Configuracion): Observable<Configuracion> {
    return this.http.put<Configuracion>(this.apiUrl, config);
  }
}
