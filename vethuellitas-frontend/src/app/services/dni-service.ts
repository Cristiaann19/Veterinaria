import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { DatosDni } from '../models/dni';

@Injectable({ providedIn: 'root' })
export class DniService {
  private apiUrl = 'http://localhost:8080/api/dni';

  constructor(private http: HttpClient) {}

  consultarDni(dni: string): Observable<DatosDni> {
    return this.http.get<DatosDni>(`${this.apiUrl}/${dni}`);
  }
}
