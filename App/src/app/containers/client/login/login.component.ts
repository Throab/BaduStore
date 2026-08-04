import { AfterViewInit, Component, NgZone, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NzMessageService } from 'ng-zorro-antd/message';
import { FormHelper } from '../../../core/util/form-helper';
import { ShareModule } from '../../../share.module';
import { UserService } from '../../../core/service/user.service';
import { environment } from '../../../../environments/environment';
import { CartService } from '../../../core/service/cart.service';
import { catchError, of, switchMap } from 'rxjs';
import { GuestService } from '../../../core/service/guest.service';
declare const google: any;
@Component({
  selector: 'app-login',
  imports: [ShareModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit, AfterViewInit {
  formData!: FormGroup;

  isShowPassword: boolean = false;

  constructor(
    public service: UserService,
    public formBuilder: FormBuilder,
    public messageService: NzMessageService,
    public ngZone: NgZone,
    public router: Router,
    public cartService: CartService,
    public guestService: GuestService,
  ) {}
  ngAfterViewInit(): void {}

  ngOnInit() {
    // @ts-ignore
    google.accounts.id.initialize({
      client_id: environment.ClientId,
      callback: this.handleCredentialResponse.bind(this),
      auto_select: false,
      cancel_on_tap_outside: true,
    });
    // @ts-ignore
    google.accounts.id.renderButton(
      // @ts-ignore
      document.getElementById('googleButton'),
      { theme: 'outline', size: 'large', width: '100%' },
    );
    // @ts-ignore
    google.accounts.id.prompt((notification: PromptMomentNotification) => {});
    this.formData = this.formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
      remember: [true],
    });
  }
  async handleCredentialResponse(response: any) {
    this.service.googleLogin(response.credential).subscribe({
      next: () => {
        this.messageService.success('Đăng nhập Google thành công');
        this.cartService.LoadCart();
        this.navigate('/');
      },
      error: (err) => {
        this.messageService.error(err.error);
      },
    });
  }
  onSubmit() {
    FormHelper.markAsDirty(this.formData);
    if (this.formData.invalid) {
      return;
    }

    this.service.login(this.formData.getRawValue()).subscribe({
      next: () => {
        this.messageService.success('Đăng nhập thành công');
        this.cartService.LoadCart();
        this.navigate('/');
      },
      error: (error: any) => {
        this.messageService.error(error.error);
      },
    });
  }

  navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }
}
