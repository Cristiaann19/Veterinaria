import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class UploadService {
  private apiUrl = 'http://localhost:8080/api/upload';

  constructor(private http: HttpClient) {}

  subir(archivo: File): Observable<{ url: string }> {
    const formData = new FormData();
    formData.append('file', archivo);
    return this.http.post<{ url: string }>(this.apiUrl, formData);
  }
}
