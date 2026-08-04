import { Injectable } from '@angular/core';
import {
  HttpEvent,
  HttpHandler,
  HttpInterceptor,
  HttpRequest,
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { Constants } from '../core/util/constants';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  intercept(
    request: HttpRequest<any>,
    next: HttpHandler,
  ): Observable<HttpEvent<any>> {
    let session = localStorage.getItem(Constants.LOCAL_STORAGE_KEY.SESSION);

    if (location.href.includes('/admin')) {
      session = localStorage.getItem(Constants.LOCAL_STORAGE_KEY.TOKEN_ADMIN);
    }

    const headers: { [key: string]: string } = {};

    // Nếu đã đăng nhập thì gửi JWT
    if (session) {
      const data = JSON.parse(session);
      headers['Authorization'] = `Bearer ${data.token}`;
    } else {
      let guestId = localStorage.getItem('guestId');

      if (!guestId) {
        guestId = crypto.randomUUID();
        localStorage.setItem('guestId', guestId);
      }

      headers['Guest-Id'] = guestId;
    }

    request = request.clone({
      setHeaders: headers,
    });
    return next.handle(request);
  }
}
