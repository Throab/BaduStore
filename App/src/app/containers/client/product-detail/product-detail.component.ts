import {
  AfterViewInit,
  Component,
  NgZone,
  OnChanges,
  OnInit,
} from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router } from '@angular/router';
import { NzMessageService } from 'ng-zorro-antd/message';
import { Product } from '../../../core/model/product';
import { ProductService } from '../../../core/service/product.service';
import { ProductAttribute } from '../../../core/model/product-attribute';
import { ShareModule } from '../../../share.module';
import { groupBy } from 'rxjs';
import { Attribute } from '../../../core/model/attribute';
import { FormGroup } from '@angular/forms';
import { FormBuilder } from '@angular/forms';
import { FormHelper } from '../../../core/util/form-helper';
import { Validators } from '@angular/forms';
import { Review } from '../../../core/model/review';
import { ReviewService } from '../../../core/service/review.service';
declare var $: any;

@Component({
  selector: 'app-product-detail',
  imports: [ShareModule],
  templateUrl: './product-detail.component.html',
  styleUrl: './product-detail.component.css',
})
export class ProductDetailComponent implements OnInit, AfterViewInit {
  productAlias: string = '';
  reviews: Review[] = [];
  product!: Product;
  image: string = './assets/imgs/tivi.png';
  reviewForm!: FormGroup;
  averageRating = 0;

  constructor(
    public service: ProductService,
    public activatedRoute: ActivatedRoute,
    public messageService: NzMessageService,
    public router: Router,
    public formBuilder: FormBuilder,
    public ngZone: NgZone,
  ) {
    this.router.events
      .forEach((event) => {
        if (event instanceof NavigationEnd) {
          this.productAlias = this.activatedRoute.snapshot.params['alias'];
          this.getData();
        }
      })
      .then();
  }
  ngAfterViewInit(): void {
    console.log('ádasd');
    setTimeout(() => {
      ($('.product-large-slider') as any).slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        fade: true,
        arrows: false,
        asNavFor: '.pro-nav',
      });
      ($('.pro-nav') as any).slick({
        slidesToShow: 5,
        slidesToScroll: 1,
        prevArrow:
          '<button type="button" class="arrow-prev"><i class="fa fa-long-arrow-left"></i></button>',
        nextArrow:
          '<button type="button" class="arrow-next"><i class="fa fa-long-arrow-right"></i></button>',
        asNavFor: '.product-large-slider',
        centerMode: true,
        arrows: true,
        centerPadding: '0px',
        focusOnSelect: true,
      });
      $('.img-popup').magnificPopup({
        type: 'image',
        gallery: {
          enabled: true,
        },
      });
      // owl carousel active
      const flash_sale = $('.flash-sale-active4');
      flash_sale.owlCarousel({
        loop: true,
        margin: 30,
        dots: false,
        autoplay: false,
        nav: true,
        navText: [
          '<i class="lnr lnr-arrow-left"></i>',
          '<i class="lnr lnr-arrow-right"></i>',
        ],
        stagePadding: 0,
        smartSpeed: 700,
        responsive: {
          0: {
            items: 1,
          },
          480: {
            items: 2,
          },
          768: {
            items: 3,
          },
          992: {
            items: 4,
          },
          1024: {
            items: 5,
          },
          1600: {
            items: 6,
          },
        },
      });
    }, 500);
  }
  ngOnInit() {
    this.productAlias = this.activatedRoute.snapshot.params['alias'];
    this.getData();
  }
  onSubmit(): void {
    FormHelper.markAsDirty(this.reviewForm);
    const session = JSON.parse(localStorage.getItem('session') || '{}');

    const newReview: Partial<Review> = {
      productId: this.product.id,
      customerId: session.id,
      ratingValue: this.reviewForm.value.rating,
      comment: this.reviewForm.value.comment,
    };
    if (this.reviewForm.invalid) {
      return;
    }
    if (session.id == null) {
      this.messageService.error('Vui lòng đăng nhập');
      this.navigate('/dang-nhap');
    }
  }
  getData() {
    this.service.GetByAlias(this.productAlias).subscribe((resp: any) => {
      this.product = resp;
    });
  }
  navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }
}
