import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { GuestService } from './core/service/guest.service';
import { CartService } from './core/service/cart.service';
@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent implements OnInit {
  title = 'App';
  constructor(
    private guestService: GuestService,
    private cartService: CartService,
  ) {}
  ngOnInit(): void {}
}
