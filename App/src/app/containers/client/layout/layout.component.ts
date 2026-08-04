import { AfterViewInit, Component, OnInit, NgZone } from '@angular/core';
import { ShareModule } from '../../../share.module';
import { Category } from '../../../core/model/category';
import { CategoryService } from '../../../core/service/category.service';
import { Constants } from '../../../core/util/constants';
import { Router } from '@angular/router';
import { CartService } from '../../../core/service/cart.service';
import { GuestService } from '../../../core/service/guest.service';
import { Cart } from '../../../core/model/cart';

declare var $: any;
@Component({
  selector: 'app-layout',
  imports: [ShareModule],
  templateUrl: './layout.component.html',
  styleUrl: './layout.component.css',
})
export class LayoutComponent implements OnInit, AfterViewInit {
  categories: Category[] = [];
  keySearch: string = '';
  cart: Cart | null = null;
  cartItems: any[] = [];
  constructor(
    public CategoryService: CategoryService,
    public ngZone: NgZone,
    public router: Router,
    public guestService: GuestService,
    public cartService: CartService,
  ) {}
  ngOnInit(): void {
    this.guestService.getGuestId();
    this.cartService.LoadCart();
    this.cartService.cart$.subscribe((cart: Cart | null) => {
      this.cart = cart;
      this.cartItems = cart?.items ?? [];
    });
    this.getAllCategory();
  }
  get isAuth(): boolean {
    const session = localStorage.getItem(Constants.LOCAL_STORAGE_KEY.SESSION);

    if (!session) return false;

    const data = JSON.parse(session);

    return !!data.token;
  }
  ngAfterViewInit(): void {
    let cThis = this;
    setTimeout(() => {
      /*Header Cart
    -----------------------------------*/
      var headerActionToggle = $('.ha-toggle');
      var headerActionDropdown = $('.ha-dropdown');
      // Toggle Header Cart
      headerActionToggle.on('click', function (event: any) {
        var $this = $(event.target);
        headerActionDropdown.slideUp();
        if ($this.siblings('.ha-dropdown').is(':hidden')) {
          $this.siblings('.ha-dropdown').slideDown();
        } else {
          $this.siblings('.ha-dropdown').slideUp();
        }
      });
      // Prevent closing Header Cart upon clicking inside the Header Cart
      $('.ha-dropdown').on('click', function (e: any) {
        e.stopPropagation();
      });
    }, 500);
  }
  getAllCategory() {
    this.CategoryService.getAll().subscribe((resp: any) => {
      this.categories = resp;
    });
  }
  getCartCount(): number {
    const cart = localStorage.getItem(Constants.LOCAL_STORAGE_KEY.CART);
    if (!cart) return 0;
    const cartItems = JSON.parse(cart);
    return cartItems.length;
  }
  search() {
    if (!this.keySearch.trim()) return;

    this.router.navigate(['/tim-kiem'], {
      queryParams: {
        keySearch: this.keySearch,
      },
    });
  }
  public navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }
  removeItem(productId: number) {
    this.cartService.RemoveItem(productId).subscribe({
      next: () => {
        this.cartService.LoadCart();
      },
    });
  }
}
