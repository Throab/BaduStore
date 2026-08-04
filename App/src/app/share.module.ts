import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxSpinnerModule } from 'ngx-spinner';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DENgZorroAntdModule } from './ng-zorro-antd.module';
import { RouterLink, RouterLinkWithHref, RouterModule } from '@angular/router';
import { ProductTemplateComponent } from './components/product-template/product-template.component';
import { NgxCurrencyDirective } from 'ngx-currency';
@NgModule({
  declarations: [ProductTemplateComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    DENgZorroAntdModule,
    RouterLinkWithHref,
    NgxCurrencyDirective,
  ],
  exports: [
    CommonModule,
    FormsModule,
    RouterModule,
    ReactiveFormsModule,
    NgxSpinnerModule,
    DENgZorroAntdModule,
    NgxCurrencyDirective,
    ProductTemplateComponent,
  ],
})
export class ShareModule {}
