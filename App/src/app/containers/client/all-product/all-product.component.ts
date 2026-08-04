import { Component, OnInit } from '@angular/core';
import { ShareModule } from '../../../share.module';
import { ProductService } from '../../../core/service/product.service';
import { Product } from '../../../core/model/product';
import { Category } from '../../../core/model/category';
import { CategoryService } from '../../../core/service/category.service';
import { Brand } from '../../../core/model/brand';
import { BrandService } from '../../../core/service/brand.service';
import { NavigationEnd, ActivatedRoute, Router } from '@angular/router';
import { NumberValueAccessor } from '@angular/forms';
import { filter } from 'rxjs';
@Component({
  selector: 'app-all-product',
  imports: [ShareModule],
  templateUrl: './all-product.component.html',
  styleUrl: './all-product.component.css',
})
export class AllProductComponent implements OnInit {
  products: Product[] = [];
  categories: Category[] = [];
  brands: Brand[] = [];
  displayedProducts: Product[] = [];
  currentPage: number = 1;
  pageSize: number = 12;
  totalProducts: number = 0;
  sortOption: string = 'default';
  cateId: number = 0;
  brandId: number = 0;

  constructor(
    private productService: ProductService,
    private categoryService: CategoryService,
    private brandService: BrandService,
    public router: Router,
    public activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.loadProducts();
    this.loadCategory();
    this.loadBrand();
  }

  loadProducts(): void {
    this.productService.getAll().subscribe((resp: any) => {
      this.products = resp;
      this.totalProducts = resp.length;
    });
  }
  loadCategory(): void {
    this.categoryService.getAll().subscribe((resp: any) => {
      this.categories = resp;
    });
  }
  loadBrand(): void {
    this.brandService.getAll().subscribe((resp: any) => {
      this.brands = resp;
    });
  }

  // sortProducts(option: string): void {
  //   this.sortOption = option;

  //   switch (option) {
  //     case 'price-asc':
  //       this.products.sort((a, b) => a.price - b.price);
  //       break;
  //     case 'price-desc':
  //       this.products.sort((a, b) => b.price - a.price);
  //       break;
  //     case 'name-asc':
  //       this.products.sort((a, b) => a.name.localeCompare(b.name));
  //       break;
  //     case 'name-desc':
  //       this.products.sort((a, b) => b.name.localeCompare(a.name));
  //       break;
  //     case 'newest':
  //       this.products.sort(
  //         (a, b) =>
  //           new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
  //       );
  //       break;
  //     case 'bestselling':
  //       this.products.sort((a, b) => b.soldQuantity - a.soldQuantity);
  //       break;
  //     default:
  //       // Default sorting (perhaps by ID or as they come from API)
  //       break;
  //   }

  //   this.currentPage = 1;
  //   this.updateDisplayedProducts();
  // }

  updateDisplayedProducts(): void {
    const startIndex = (this.currentPage - 1) * this.pageSize;
    const endIndex = startIndex + this.pageSize;
    this.displayedProducts = this.products.slice(startIndex, endIndex);
  }

  pageChange(page: number): void {
    this.currentPage = page;
    this.updateDisplayedProducts();
    window.scrollTo(0, 0); // Scroll to top when page changes
  }
}
