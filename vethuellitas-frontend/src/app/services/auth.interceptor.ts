import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { catchError, throwError } from 'rxjs';
import { GToast } from './gtoast';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);
  const toast = inject(GToast);
  const token = localStorage.getItem('token');

  const authReq = token
    ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
    : req;

  return next(authReq).pipe(
    catchError((err) => {
      const sesionExpirada = (err?.status === 401 || err?.status === 403)
        && !authReq.url.includes('/api/auth/')
        && !!localStorage.getItem('token');

      if (sesionExpirada) {
        localStorage.clear();
        toast.error('Sesión expirada, vuelve a iniciar sesión', { summary: 'Sesión expirada' });
        if (router.url !== '/login') {
          router.navigate(['/login']);
        }
      }

      return throwError(() => err);
    })
  );
};
