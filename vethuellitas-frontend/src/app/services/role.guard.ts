import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from './auth.service';

export const roleGuard: CanActivateFn = (route) => {
  const auth = inject(AuthService);
  const router = inject(Router);

  if (!auth.isLoggedIn()) {
    router.navigate(['/login']);
    return false;
  }

  const rol = auth.getRol() ?? '';
  const allowedRoles: string[] = route.data?.['roles'] ?? [];

  if (allowedRoles.length > 0 && !allowedRoles.includes(rol)) {
    router.navigate(['/admin/dashboard']);
    return false;
  }

  return true;
};
