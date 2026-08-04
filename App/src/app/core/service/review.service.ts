import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BaseService } from './base.service';

@Injectable({
  providedIn: 'root',
})
export class ReviewService extends BaseService {
  constructor(http: HttpClient) {
    super(http, 'Review');
  }
  getByAlias(alias: string) {
    return this.http.get(this.routerPrefix + '/get-by-alias', {
      params: {
        alias,
      },
    });
  }
  getAvg(alias: string) {
    return this.http.get(this.routerPrefix + '/get-average-rating', {
      params: {
        alias,
      },
    });
  }
}
