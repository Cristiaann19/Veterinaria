import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {catchError, Observable, of} from 'rxjs';

@Injectable({ providedIn: 'root' })
export class UploadService {
  private apiUrl = 'http://localhost:8080/api/upload';

  constructor(private http: HttpClient) {}

  subir(archivo: File): Observable<{ url: string; error?: string }> {
    const formData = new FormData();
    formData.append('file', archivo);
    return this.http.post<{ url: string; error?: string }>(this.apiUrl, formData).pipe(
      catchError((err) => {
        const msg = err.error?.error?.message || err.message || 'Error al subir archivo';
        return of({ url: '', error: msg });
      })
    );
  }
}
