import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Venta, VentaRequestDTO } from '../models/carrito';

@Injectable({ providedIn: 'root' })
export class VentaService {
  private url = 'http://localhost:8080/api/ventas';

  constructor(private http: HttpClient) {}

  realizarVenta(dto: VentaRequestDTO): Observable<Venta> {
    return this.http.post<Venta>(this.url, dto);
  }

  listarTodas(): Observable<Venta[]> {
    return this.http.get<Venta[]>(this.url);
  }

  listarPorCliente(clienteId: number): Observable<Venta[]> {
    return this.http.get<Venta[]>(`${this.url}/cliente/${clienteId}`);
  }
}
