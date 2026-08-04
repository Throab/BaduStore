import { AfterViewInit, Component, OnInit } from '@angular/core';
import { Product } from '../../../core/model/product';
import { Category } from '../../../core/model/category';
import { ShareModule } from '../../../share.module';
import { ProductService } from '../../../core/service/product.service';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { CategoryService } from '../../../core/service/category.service';
import { Constants } from '../../../core/util/constants';
declare var $: any;
@Component({
  selector: 'app-home',
  imports: [ShareModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class HomeComponent implements OnInit, AfterViewInit {
  products: Product[] = [];
  categories: Category[] = [];
  customerId: number = 0;
  customOptions: OwlOptions = {
    loop: false,
    items: 1,
    margin: 10,
    mouseDrag: true,
    touchDrag: false,
    pullDrag: false,
    dots: true,
    navSpeed: 700,
    nav: true,
    navText: [
      `<i class="fa fa-angle-left" aria-hidden="true"></i>`,
      `<i class="fa fa-angle-right" aria-hidden="true"></i>`,
    ],
  };
  customProductOptions: OwlOptions = {
    loop: true,
    margin: 10,
    items: 1,
    mouseDrag: true,
    touchDrag: true,
    pullDrag: false,
    autoplay: true,
    dots: false,
    navSpeed: 700,
    nav: true,
    autoWidth: false,
    autoHeight: false,
    mergeFit: true,
    navText: [
      `<i class="fa fa-angle-left" aria-hidden="true"></i>`,
      `<i class="fa fa-angle-right" aria-hidden="true"></i>`,
    ],
    responsive: {
      0: { items: 1 },
      520: {
        items: 1,
      },
      720: {
        items: 2,
      },
      932: {
        items: 3,
      },
      1200: {
        items: 5,
      },
    },
  };
  constructor(
    public ProductService: ProductService,
    public CategoryService: CategoryService,
  ) {}
  ngOnInit(): void {
    this.getProduct();
    this.getCategory();
  }
  getProduct() {
    let store = localStorage.getItem('session');
    if (store) {
      this.customerId = JSON.parse(store).id;
    }
    this.ProductService.GetHotProduct().subscribe((resp: any) => {
      this.products = resp;
    });
  }
  getCategory() {
    this.CategoryService.getAll().subscribe((resp: any) => {
      this.categories = resp;
    });
  }
  ngAfterViewInit(): void {
    let product = $('.product-gallary-active');
    product.owlCarousel({
      loop: true,
      dots: false,
      margin: 30,
      nav: true,
      navText: [
        '<i class="lnr lnr-arrow-left"></i>',
        '<i class="lnr lnr-arrow-right"></i>',
      ],
      autoplay: false,
      stagePadding: 0,
      smartSpeed: 700,
      responsive: {
        0: {
          items: 1,
          nav: false,
        },
        480: {
          items: 2,
          nav: false,
        },
        768: {
          items: 3,
        },
        992: {
          items: 4,
        },
        1024: {
          items: 4,
        },
        1600: {
          items: 7,
        },
      },
    });

    // product slider
    var product2 = $('.product-gallary-active2');
    product2.owlCarousel({
      items: 5,
      loop: true,
      dots: false,
      margin: 30,
      nav: true,
      navText: [
        '<i class="lnr lnr-arrow-left"></i>',
        '<i class="lnr lnr-arrow-right"></i>',
      ],
      autoplay: false,
      stagePadding: 0,
      smartSpeed: 700,
      responsive: {
        0: {
          items: 1,
          nav: false,
        },
        480: {
          items: 2,
          nav: false,
        },
        768: {
          items: 3,
        },

        992: {
          items: 3,
        },

        1024: {
          items: 4,
        },
        1600: {
          items: 6,
        },
      },
    });

    // owl carousel active
    product = $('.product-gallary-active3');
    product.owlCarousel({
      loop: true,
      dots: false,
      margin: 30,
      nav: true,
      navText: [
        '<i class="lnr lnr-arrow-left"></i>',
        '<i class="lnr lnr-arrow-right"></i>',
      ],
      autoplay: false,
      stagePadding: 0,
      smartSpeed: 700,
      responsive: {
        0: {
          items: 1,
          nav: false,
        },
        480: {
          items: 2,
          nav: false,
        },
        768: {
          items: 2,
        },
        992: {
          items: 3,
        },
        1024: {
          items: 3,
        },
        1600: {
          items: 5,
        },
      },
    });

    // owl carousel active
    var featured = $('.pro-module-four-active');
    featured.owlCarousel({
      items: 3,
      loop: true,
      dots: false,
      margin: 30,
      nav: true,
      navText: [
        '<i class="lnr lnr-arrow-left"></i>',
        '<i class="lnr lnr-arrow-right"></i>',
      ],
      autoplay: false,
      stagePadding: 0,
      smartSpeed: 700,
      responsive: {
        0: {
          items: 1,
          nav: false,
        },
        480: {
          items: 1,
          nav: false,
        },
        768: {
          items: 2,
        },
        992: {
          items: 3,
        },
        1024: {
          items: 3,
        },
        1600: {
          items: 4,
        },
      },
    });

    // magnificPopup img view
    $('.img-popup').magnificPopup({
      type: 'image',
      gallery: {
        enabled: true,
      },
    });

    // magnificPopup video view
    $('.play-btn').magnificPopup({
      type: 'iframe',
    });

    $(window).on('scroll', () => {
      if ($(window).scrollTop() > 600) {
        $('.scroll-top').removeClass('not-visible');
      } else {
        $('.scroll-top').addClass('not-visible');
      }
    });

    $('.scroll-top').on('click', function (event: any) {
      console.log('scroll-top');
      $('html,body').animate(
        {
          scrollTop: 0,
        },
        1000,
      );
    });

    // product details slider active
    $('.product-large-slider').slick({
      slidesToShow: 1,
      slidesToScroll: 1,
      fade: true,
      arrows: false,
      asNavFor: '.pro-nav',
    });

    // slick carousel active
    $('.pro-nav').slick({
      slidesToShow: 5,
      slidesToScroll: 1,
      prevArrow:
        '<button type="button" class="arrow-prev"><i class="fa fa-long-arrow-left"></i></button>',
      nextArrow:
        '<button type="button" class="arrow-next"><i class="fa fa-long-arrow-right"></i></button>',
      asNavFor: '.product-large-slider',
      centerMode: true,
      arrows: true,
      centerPadding: 0,
      focusOnSelect: true,
    });

    // product details vertical slider active
    $('.product-large-slider1').slick({
      slidesToShow: 1,
      slidesToScroll: 1,
      fade: true,
      arrows: false,
      asNavFor: '.pro-nav1',
    });

    // slick carousel active
    $('.pro-nav1').slick({
      slidesToShow: 5,
      slidesToScroll: 1,
      prevArrow:
        '<button type="button" class="arrow-prev"><i class="fa fa-long-arrow-up"></i></button>',
      nextArrow:
        '<button type="button" class="arrow-next"><i class="fa fa-long-arrow-down"></i></button>',
      asNavFor: '.product-large-slider1',
      centerMode: true,
      arrows: true,
      vertical: true,
      centerPadding: 0,
      focusOnSelect: true,
    });

    // modal fix
    $('.modal').on('shown.bs.modal', function (e: any) {
      $('.pro-nav').resize();
    });
  }
}
