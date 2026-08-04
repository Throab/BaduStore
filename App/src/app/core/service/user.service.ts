import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { map } from 'rxjs/operators';
import { Constants } from '../util/constants';
import { User } from '../model/user';

@Injectable({
  providedIn: 'root',
})
export class UserService extends BaseService {
  constructor(http: HttpClient) {
    super(http, 'Auth');
  }

  login(user: User) {
    return this.http.post(this.routerPrefix + '/login', user).pipe(
      map((resp: any) => {
        localStorage.setItem(
          Constants.LOCAL_STORAGE_KEY.SESSION,
          JSON.stringify(resp),
        );
        // localStorage.setItem(Constants.LOCAL_STORAGE_KEY.TOKEN, resp['token']);
        return resp;
      }),
    );
  }

  register(user: User) {
    return this.http.post(this.routerPrefix + '/register', user);
  }
  googleLogin(token: string) {
    return this.http
      .post(this.routerPrefix + '/google-login', {
        Token: token,
      })
      .pipe(
        map((resp: any) => {
          localStorage.setItem(
            Constants.LOCAL_STORAGE_KEY.SESSION,
            JSON.stringify(resp),
          );

          return resp;
        }),
      );
  }
  requestOTP(email: string) {
    return this.http.get(this.routerPrefix + '/request-otp', {
      params: {
        email,
      },
    });
  }

  confirmOTP(email: string, otp: string) {
    return this.http.get(this.routerPrefix + '/confirm-otp', {
      params: {
        email,
        otp,
      },
    });
  }

  forgotPassword(email: string) {
    return this.http.get(this.routerPrefix + '/forgot-password', {
      params: {
        email,
      },
    });
  }

  getProfile() {
    return this.http.get(this.routerPrefix + '/me');
  }

  updateProfile(entity: any) {
    return this.http.put(this.routerPrefix + '/me', entity);
  }

  getOrders() {
    return this.http.get(this.routerPrefix + '/get-orders');
  }

  changePassword(email: string, oldPassword: string, newPassword: string) {
    return this.http.put(this.routerPrefix + '/me/password', {
      email,
      oldPassword,
      newPassword,
    });
  }

  addWishListProduct(productId: number) {
    return this.http.get(this.routerPrefix + '/add-wishlist-product', {
      params: {
        productId,
      },
    });
  }

  removeWishListProduct(productId: number) {
    return this.http.get(this.routerPrefix + '/remove-wishlist-product', {
      params: {
        productId,
      },
    });
  }

  getWishListProduct(orderBy: string, price: string, take: number) {
    return this.http.get(this.routerPrefix + '/get-wishlist-product', {
      params: {
        orderBy,
        price,
        take,
      },
    });
  }

  getTotalItemWishlist() {
    return this.http.get(this.routerPrefix + '/get-total-wishlist');
  }
}
