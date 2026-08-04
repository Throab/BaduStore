import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import moment from 'moment';
import { NzMessageService } from 'ng-zorro-antd/message';
import { finalize } from 'rxjs/operators';
import { FormHelper } from '../../../core/util/form-helper';
// import {Order} from '../../../core/model/order';
import { ShareModule } from '../../../share.module';
import { UserService } from '../../../core/service/user.service';
import { User } from '../../../core/model/user';
import { Order } from '../../../core/model/order';

@Component({
  selector: 'app-profile',
  imports: [ShareModule],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {
  formData!: FormGroup;
  formChangePassword!: FormGroup;
  profile!: User;
  nzLoading: boolean = false;
  orders: Order[] = [];

  constructor(
    public service: UserService,
    public messageService: NzMessageService,
    public formBuilder: FormBuilder,
  ) {}

  ngOnInit() {
    this.formData = this.formBuilder.group({
      email: [{ value: '', disabled: true }, Validators.required],
      fullName: [null, Validators.required],
      phoneNumber: [null, Validators.required],
      address: [null],
      dateOfBirth: [null],
      gender: [null],
    });
    this.formChangePassword = this.formBuilder.group({
      oldPassword: [null, Validators.required],
      newPassword: [null, Validators.required],
    });
    this.getProfile();
  }

  getProfile() {
    this.service.getProfile().subscribe((resp: any) => {
      this.profile = resp;
      this.formData.patchValue(this.profile);
    });
  }

  getOrders() {
    this.service.getOrders().subscribe((resp: any) => {
      this.orders = resp;
    });
  }

  // filterOrderByStatus(status: number): Order[] {
  //   return this.orders.filter((x) => x.status == status);
  // }

  submitForm(): void {
    FormHelper.markAsDirty(this.formData);
    if (this.formData.invalid) {
      return;
    }

    let dataPost = this.formData.getRawValue();
    if (dataPost.dateOfBirth)
      dataPost.dateOfBirth = moment(new Date(dataPost.dateOfBirth)).format(
        'YYYY-MM-DDTHH:mm:ss',
      );
    console.log(dataPost.address);

    this.nzLoading = true;
    this.service
      .updateProfile(dataPost)
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe({
        next: () => {
          this.messageService.success('Cập nhật thành công');
          this.getProfile();
        },
        error: (error: any) => {
          this.messageService.error(error.error);
        },
      });
  }

  submitChangePassword(): void {
    for (const i in this.formChangePassword.controls) {
      if (this.formChangePassword.controls.hasOwnProperty(i)) {
        this.formChangePassword.controls[i].markAsDirty();
        this.formChangePassword.controls[i].updateValueAndValidity();
      }
    }
    if (this.formChangePassword.invalid) {
      return;
    }

    const dataPost = this.formChangePassword.getRawValue();
    this.nzLoading = true;
    this.service
      .changePassword(
        this.profile.email,
        dataPost['oldPassword'],
        dataPost['newPassword'],
      )
      .pipe(
        finalize(() => {
          this.nzLoading = false;
        }),
      )
      .subscribe({
        next: () => {
          this.messageService.success('Cập nhật thành công');
          this.formChangePassword.reset();
        },
        error: (error: any) => {
          this.messageService.error(error.error);
        },
      });
  }
}
