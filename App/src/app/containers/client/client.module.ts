import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { LayoutComponent } from './layout/layout.component';
import { HomeComponent } from './home/home.component';
import { ShareModule } from '../../share.module';
import { ProductDetailComponent } from './product-detail/product-detail.component';
import { AllProductComponent } from './all-product/all-product.component';
import { SearchComponent } from './search/search.component';
import { LogoutComponent } from './logout/logout.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { ProfileComponent } from './profile/profile.component';
import { AuthGuardService } from '../../Auth/auth-guard.service';
import { CheckoutComponent } from './checkout/checkout.component';
import { OrderSuccessfulComponent } from './order-successful/order-successful.component';

const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    children: [
      {
        path: '',
        component: HomeComponent,
      },
      {
        path: 'san-pham/:alias',
        component: ProductDetailComponent,
      },
      {
        path: 'danh-sach-san-pham',
        component: SearchComponent,
      },
      {
        path: 'tim-kiem',
        component: SearchComponent,
      },

      {
        path: 'dang-xuat',
        component: LogoutComponent,
      },
      {
        path: 'dang-nhap',
        component: LoginComponent,
      },
      {
        path: 'dang-ky',
        component: RegisterComponent,
      },
      {
        path: 'profile',
        canActivate: [AuthGuardService],
        component: ProfileComponent,
      },
      {
        path: 'checkout',
        canActivate: [AuthGuardService],
        component: CheckoutComponent,
      },
      {
        path: 'dat-hang-thanh-cong',
        canActivate: [AuthGuardService],
        component: OrderSuccessfulComponent,
      },
    ],
  },
];
@NgModule({
  declarations: [],
  imports: [CommonModule, RouterModule.forChild(routes), ShareModule],
})
export class ClientModule {}
// import { RouterModule, Routes } from '@angular/router';
// import { LayoutComponent } from './layout/layout.component';
// import { AuthGuardService } from '../../Auth/auth-guard.service';
// import { NgModel } from '@angular/forms';
// import { ShareModule } from '../../share.module';
// import { NgModule } from '@angular/core';
// import { CommonModule } from '@angular/common';

// export const routes: Routes = [
//   {
//     path: '',
//     component: LayoutComponent,
//     children: [
//       {
//         path: '',
//         loadComponent: () =>
//           import('./home/home.component').then((m) => m.HomeComponent),
//       },
//       {
//         path: 'san-pham/:alias',
//         loadComponent: () =>
//           import('./product-detail/product-detail.component').then(
//             (m) => m.ProductDetailComponent,
//           ),
//       },
//       {
//         path: 'danh-sach-san-pham',
//         loadComponent: () =>
//           import('./search/search.component').then((m) => m.SearchComponent),
//       },
//       {
//         path: 'tim-kiem',
//         loadComponent: () =>
//           import('./search/search.component').then((m) => m.SearchComponent),
//       },
//       {
//         path: 'dang-xuat',
//         loadComponent: () =>
//           import('./logout/logout.component').then((m) => m.LogoutComponent),
//       },
//       {
//         path: 'dang-nhap',
//         loadComponent: () =>
//           import('./login/login.component').then((m) => m.LoginComponent),
//       },
//       {
//         path: 'dang-ky',
//         loadComponent: () =>
//           import('./register/register.component').then(
//             (m) => m.RegisterComponent,
//           ),
//       },
//       {
//         path: 'profile',
//         canActivate: [AuthGuardService],
//         loadComponent: () =>
//           import('./profile/profile.component').then((m) => m.ProfileComponent),
//       },
//       {
//         path: 'checkout',
//         canActivate: [AuthGuardService],
//         loadComponent: () =>
//           import('./checkout/checkout.component').then(
//             (m) => m.CheckoutComponent,
//           ),
//       },
//     ],
//   },
// ];
// @NgModule({
//   declarations: [],
//   imports: [CommonModule, RouterModule.forChild(routes), ShareModule],
// })
// export class ClientModule {}
