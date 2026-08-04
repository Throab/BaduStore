import { Injectable } from '@angular/core';
import { Product } from '../model/product';
import { Constants } from '../util/constants';
import { Cart } from '../model/cart';
import { BaseService } from './base.service';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CartService extends BaseService {
  private cartSubject = new BehaviorSubject<Cart | null>(null);

  public cart$ = this.cartSubject.asObservable();
  constructor(http: HttpClient) {
    super(http, 'Carts');
  }
  LoadCart() {
    this.http.get<any>(this.routerPrefix).subscribe({
      next: (cart) => {
        this.cartSubject.next(cart);
      },
      error: (err) => {
        console.log(err);
      },
    });
  }
  AddToCart(productId: number) {
    return this.http.post(`${this.routerPrefix}`, {
      productId,
    });
  }
  RemoveItem(productId: number) {
    return this.http.delete(`${this.routerPrefix}/${productId}`);
  }
  MergeCart() {
    return this.http.post(`${this.routerPrefix}/merge`, {});
  }
}
