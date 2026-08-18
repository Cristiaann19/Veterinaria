import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Trabajador } from '../models/trabajador';

@Injectable({
  providedIn: 'root',
})
export class TrabajadorService {
  private apiUrl = 'http://localhost:8080/api/trabajadores';

  constructor(private http: HttpClient) {
  }

  // GET: listarActivos()
  listarTrabajadores(): Observable<Trabajador[]> {
    return this.http.get<Trabajador[]>(this.apiUrl);
  }

  eliminarTrabajador(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }

}
