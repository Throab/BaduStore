import { ViewportScroller } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router } from '@angular/router';
import { finalize } from 'rxjs/operators';
import { Product } from '../../../core/model/product';
import { ProductService } from '../../../core/service/product.service';
import { ShareModule } from '../../../share.module';
@Component({
  selector: 'app-search',
  imports: [ShareModule],
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent implements OnInit {
  products: Product[] = [];
  nzLoading = false;
  columnNum = 4;
  price: number[] = [0, 500000000];
  filter = {
    keySearch: '',
    categoryId: undefined as number | undefined,
    brandId: undefined as number | undefined,
    orderBy: '',
    priceFrom: 0,
    priceTo: 500000000,
    page: 1,
    pageSize: 12,
  };

  constructor(
    public service: ProductService,
    public viewportScroller: ViewportScroller,
    public activatedRoute: ActivatedRoute,
    public router: Router,
  ) {
    this.router.events.subscribe((event) => {
      if (event instanceof NavigationEnd) {
        this.loadFilter();
        this.getData();
      }
    });
  }

  ngOnInit(): void {
    this.loadFilter();
    this.getData();
  }

  private loadFilter(): void {
    const query = this.activatedRoute.snapshot.queryParams;

    this.filter.keySearch = query['keySearch'] ?? '';

    this.filter.categoryId = query['categoryId']
      ? Number(query['categoryId'])
      : undefined;

    this.filter.brandId = query['brandId']
      ? Number(query['brandId'])
      : undefined;

    this.filter.orderBy = query['orderBy'] ?? '';

    this.filter.priceFrom = query['priceFrom'] ? Number(query['priceFrom']) : 0;

    this.filter.priceTo = query['priceTo']
      ? Number(query['priceTo'])
      : 500000000;
    this.price = [this.filter.priceFrom, this.filter.priceTo];
    this.filter.page = 1;
  }

  getData(): void {
    this.service.search(this.filter).subscribe((resp: any) => {
      this.products = resp;
    });
  }

  changeView(col: number): void {
    this.columnNum = col;
  }
  onPriceRangeChange(): void {
    this.filter.priceFrom = this.price[0];
    this.filter.priceTo = this.price[1];

    this.filter.page = 1;

    this.getData();
  }
  onPriceChange(index: number, value: number): void {
    if (index === 0) {
      this.filter.priceFrom = value;
    } else {
      this.filter.priceTo = value;
    }

    this.price = [this.filter.priceFrom, this.filter.priceTo];

    this.filter.page = 1;

    this.getData();
  }

  changeSort(order: string): void {
    this.filter.orderBy = order;
    this.filter.page = 1;
    this.getData();
  }

  changeCategory(categoryId: number): void {
    this.filter.categoryId = categoryId;
    this.filter.page = 1;
    this.getData();
  }

  changeBrand(brandId: number): void {
    this.filter.brandId = brandId;
    this.filter.page = 1;
    this.getData();
  }

  showMore(): void {
    const currentLocation = this.viewportScroller.getScrollPosition();

    this.filter.page++;

    this.nzLoading = true;

    this.service
      .search(this.filter)
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe((resp: any) => {
        this.products = [...this.products, ...resp];

        setTimeout(() => {
          this.viewportScroller.scrollToPosition(currentLocation);
        }, 10);
      });
  }
}
