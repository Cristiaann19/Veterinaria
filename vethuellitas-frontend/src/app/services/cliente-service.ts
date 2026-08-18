// services/cliente-service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Cliente } from '../models/cliente';

@Injectable({ providedIn: 'root' })
export class ClienteService {
  private url = 'http://localhost:8080/api/clientes';

  constructor(private http: HttpClient) {}

  listarClientes(): Observable<Cliente[]> {
    return this.http.get<Cliente[]>(this.url);
  }

  crearCliente(cliente: Cliente): Observable<Cliente> {
    return this.http.post<Cliente>(this.url, cliente);
  }

  actualizarCliente(id: number, cliente: Cliente): Observable<Cliente> {
    return this.http.put<Cliente>(`${this.url}/${id}`, cliente);
  }

  eliminarCliente(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`);
  }
}
