import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class GuestService {
  private readonly KEY = 'guestId';

  getGuestId(): string {
    let guestId = localStorage.getItem(this.KEY);
    if (!guestId) {
      guestId = crypto.randomUUID();
      localStorage.setItem(this.KEY, guestId);
    }
    return guestId;
  }

  clearGuestId() {
    localStorage.removeItem(this.KEY);
  }
}
