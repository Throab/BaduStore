import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { environment } from '../../../environments/environment';
import { Product } from '../model/product';
@Injectable({
  providedIn: 'root',
})
export class ProductService extends BaseService {
  constructor(http: HttpClient) {
    super(http, 'Products');
  }
  search(filter: any) {
    return this.http.get<Product[]>(`${this.routerPrefix}/search`, {
      params: {
        ...(filter.keySearch && { keySearch: filter.keySearch }),
        ...(filter.categoryId && { categoryId: filter.categoryId }),
        ...(filter.brandId && { brandId: filter.brandId }),
        ...(filter.orderBy && { orderBy: filter.orderBy }),
        priceFrom: filter.priceFrom,
        priceTo: filter.priceTo,
        page: filter.page,
        pageSize: filter.pageSize,
      },
    });
  }
  GetHotProduct() {
    return this.http.get(this.routerPrefix + '/hot/10');
  }
  GetHotProductTest() {
    return this.http.get(this.routerPrefix + '/hot/1604');
  }
  GetByAlias(alias: string) {
    return this.http.get(`${this.routerPrefix}/${alias}`);
  }
}
