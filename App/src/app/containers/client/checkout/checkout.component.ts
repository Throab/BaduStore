import { Component, NgZone, OnInit } from '@angular/core';
import { ShareModule } from '../../../share.module';
import { CartService } from '../../../core/service/cart.service';
import { UserService } from '../../../core/service/user.service';
import { NzMessageService } from 'ng-zorro-antd/message';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { OrderService } from '../../../core/service/order.service';
import { Cart } from '../../../core/model/cart';
import { User } from '../../../core/model/user';
import { FormHelper } from '../../../core/util/form-helper';
import { finalize } from 'rxjs';

@Component({
  selector: 'app-checkout',
  imports: [ShareModule],
  templateUrl: './checkout.component.html',
  styleUrl: './checkout.component.css',
})
export class CheckoutComponent implements OnInit {
  cart: Cart | null = null;
  cartItems: any[] = [];
  profile!: User;
  formData!: FormGroup;
  nzLoading: boolean = false;
  constructor(
    public cartService: CartService,
    public orderService: OrderService,
    public userService: UserService,
    public messageService: NzMessageService,
    public formBuilder: FormBuilder,
    public ngZone: NgZone,
    public router: Router,
  ) {}
  ngOnInit(): void {
    this.formData = this.formBuilder.group({
      fullName: [{ value: '', disabled: true }, Validators.required],
      phoneNumber: [null, Validators.required],
      address: [null, Validators.required],
      userId: [{ value: '', disabled: true }, Validators.required],
    });
    this.cartService.cart$.subscribe((cart: Cart | null) => {
      this.cart = cart;
      this.cartItems = cart?.items ?? [];
    });
    this.getProfile();
  }
  getProfile() {
    this.userService.getProfile().subscribe((resp: any) => {
      this.profile = resp;
      this.formData.patchValue({
        ...resp,
        userId: resp.id,
      });
    });
  }
  submitForm() {
    FormHelper.markAsDirty(this.formData);
    if (this.formData.invalid) {
      return;
    }
    if (!this.cartItems.length) {
      this.messageService.warning('Giỏ hàng đang trống.');
      return;
    }
    this.nzLoading = true;
    this.orderService
      .checkout({
        userId: this.formData.get('userId')?.value,
        phoneNumber: this.formData.get('phoneNumber')?.value,
        address: this.formData.get('address')?.value,
        paymentMethod: 'COD',
      })
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe({
        next: () => {
          this.messageService.success('Đặt hàng thành công');

          this.cartService.LoadCart();
          this.navigate('/dat-hang-thanh-cong');
        },
        error: (err: any) => {
          this.messageService.error(err.error || 'Đặt hàng thất bại');
        },
      });
  }
  navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }
}
