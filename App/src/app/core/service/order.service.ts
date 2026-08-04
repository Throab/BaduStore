import { HttpClient } from '@angular/common/http';
import { BaseService } from './base.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class OrderService extends BaseService {
  constructor(http: HttpClient) {
    super(http, 'Orders');
  }
  checkout(data: any) {
    return this.http.post(this.routerPrefix + '/checkout', data);
  }
  getOrderHistory(userId: number) {
    return this.http.get(this.routerPrefix + `/${userId}`);
  }
}
