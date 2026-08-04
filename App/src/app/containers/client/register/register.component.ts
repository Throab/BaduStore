import { Component, NgZone, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NzMessageService } from 'ng-zorro-antd/message';
import { finalize } from 'rxjs/operators';
import { FormHelper } from '../../../core/util/form-helper';
import { UserService } from '../../../core/service/user.service';
import { ShareModule } from '../../../share.module';

@Component({
  selector: 'app-sign-up',
  imports: [ShareModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit {
  currentStep: number = 0;
  nzLoading: boolean = false;
  formMail!: FormGroup;
  formOTP!: FormGroup;
  formData!: FormGroup;
  isShowPassword: boolean = false;

  constructor(
    public UserService: UserService,
    public messageService: NzMessageService,
    public formBuilder: FormBuilder,
    public ngZone: NgZone,
    public router: Router,
  ) {}

  ngOnInit(): void {
    this.formData = this.formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
      confirmPassword: ['', Validators.required],
      fullName: ['', Validators.required],
      phoneNumber: ['', Validators.required],
    });
  }

  requestOTP() {
    for (const i in this.formMail.controls) {
      if (this.formMail.controls.hasOwnProperty(i)) {
        this.formMail.controls[i].markAsDirty();
        this.formMail.controls[i].updateValueAndValidity();
      }
    }
    if (this.formMail.invalid) {
      return;
    }
    this.nzLoading = true;

    const email = this.formMail.getRawValue().email;
    const otp = this.formOTP.getRawValue().oTP;
    this.nzLoading = true;
    this.UserService.confirmOTP(email, otp)
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe({
        next: (resp: any) => {
          let data: boolean = resp;
          if (data) {
            this.currentStep = 2;
            this.formData.patchValue({
              email: email,
              oTP: otp,
            });
          } else {
            this.messageService.error('Mã OTP không đúng.');
          }
        },
        error: (error: any) => {
          this.messageService.error(error.error);
        },
      });
  }

  onSubmit(): void {
    FormHelper.markAsDirty(this.formData);
    if (this.formData.invalid) {
      return;
    }

    this.nzLoading = true;
    this.UserService.register(this.formData.getRawValue())
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe({
        next: () => {
          this.messageService.success('Đăng ký thành công');
          this.navigate('/dang-nhap');
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
