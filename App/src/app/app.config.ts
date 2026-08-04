// import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
// import { provideRouter } from '@angular/router';

// import { routes } from './app.routes';

// export const appConfig: ApplicationConfig = {
//   providers: [
//     provideZoneChangeDetection({ eventCoalescing: true }),
//     provideRouter(routes),
//   ],
// };
import {
  ApplicationConfig,
  importProvidersFrom,
  provideZoneChangeDetection,
} from '@angular/core';
import { provideRouter } from '@angular/router';
import {
  NgxCurrencyInputMode,
  provideEnvironmentNgxCurrency,
} from 'ngx-currency';
import { routes } from './app.routes';
import {
  en_US,
  NZ_DATE_LOCALE,
  NZ_I18N,
  provideNzI18n,
  vi_VN,
} from 'ng-zorro-antd/i18n';
import { registerLocaleData } from '@angular/common';
import en from '@angular/common/locales/en';
import { FormsModule } from '@angular/forms';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import {
  HTTP_INTERCEPTORS,
  HttpClient,
  provideHttpClient,
  withInterceptorsFromDi,
} from '@angular/common/http';
import { NzConfig, provideNzConfig } from 'ng-zorro-antd/core/config';
import { vi as locale_vi } from 'date-fns/locale';

// import {
//   NgxCurrencyInputMode,
//   provideEnvironmentNgxCurrency,
// } from 'ngx-currency';
import { JwtInterceptor } from './Auth/jwt.interceptor';
import { ErrorInterceptor } from './Auth/error.interceptor';

registerLocaleData(en);

const ngZorroConfig: NzConfig = {
  notification: {
    nzPlacement: 'top',
    nzDuration: 3000,
  },
  modal: {
    nzMask: false,
  },
};

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes),
    provideNzI18n(en_US),
    importProvidersFrom(FormsModule),
    provideAnimationsAsync(),
    provideNzConfig(ngZorroConfig),
    provideEnvironmentNgxCurrency({
      align: 'left',
      allowNegative: true,
      allowZero: true,
      decimal: '.',
      precision: 0,
      prefix: '',
      suffix: '',
      thousands: ',',
      nullable: true,
      inputMode: NgxCurrencyInputMode.Natural,
    }),
    provideHttpClient(withInterceptorsFromDi()),
    {
      provide: HTTP_INTERCEPTORS,
      useClass: JwtInterceptor,
      multi: true,
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: ErrorInterceptor,
      multi: true,
    },
    { provide: NZ_I18N, useValue: en_US },
    { provide: NZ_DATE_LOCALE, useValue: locale_vi },
    importProvidersFrom([HttpClient]),
  ],
};
