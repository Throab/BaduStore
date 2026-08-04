import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () =>
      import('./containers/client/client.module').then((m) => m.ClientModule),
  },
];
