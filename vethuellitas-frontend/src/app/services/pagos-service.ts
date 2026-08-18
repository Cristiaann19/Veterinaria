import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PagosResumenDTO } from '../models/pagos';

@Injectable({ providedIn: 'root' })
export class PagosService {
  private url = 'http://localhost:8080/api/pagos';

  constructor(private http: HttpClient) {}

  getResumen(): Observable<PagosResumenDTO> {
    return this.http.get<PagosResumenDTO>(`${this.url}/resumen`);
  }
}
