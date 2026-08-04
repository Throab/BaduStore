import {
  Component,
  EventEmitter,
  Input,
  NgZone,
  OnInit,
  Output,
} from '@angular/core';
import { NzMessageService } from 'ng-zorro-antd/message';
import { Router } from '@angular/router';
import { Product } from '../../core/model/product';
import { CartService } from '../../core/service/cart.service';

@Component({
  selector: 'app-product-template',
  standalone: false,
  templateUrl: './product-template.component.html',
  styleUrl: './product-template.component.css',
})
export class ProductTemplateComponent {
  @Input() type: string = 'vertical';
  @Input() product!: Product;
  constructor(
    public messageService: NzMessageService,
    public router: Router,
    public ngZone: NgZone,
    public cartService: CartService,
  ) {}
  getThumb() {
    for (let img of this.product.images) {
      if (img.isThumb) return img.url;
    }
    return null;
  }
  public navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }
  AddToCart() {
    this.cartService.AddToCart(this.product.id).subscribe({
      next: () => {
        this.messageService.success('Thêm vào giỏ hàng thành công');
        this.cartService.LoadCart();
      },
      error: (err) => {
        console.log(err);
      },
    });
  }
}
