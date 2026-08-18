import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Enfermedad } from '../models/enfermedad';

@Injectable({
  providedIn: 'root',
})
export class EnfermedadesService {
  private url = 'http://localhost:8080/api/enfermedades';

  constructor(private http: HttpClient) { }

  listarEnfermedades(): Observable<Enfermedad[]> {
    return this.http.get<Enfermedad[]>(this.url);
  }

  crearEnfermedad(enfermedad: Enfermedad): Observable<Enfermedad> {
    return this.http.post<Enfermedad>(this.url, enfermedad);
  }

  actualizarEnfermedad(enfermedad: Enfermedad): Observable<Enfermedad> {
    return this.http.put<Enfermedad>(`${this.url}/${enfermedad.id}`, enfermedad);
  }

  eliminarEnfermedad(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`);
  }
}
