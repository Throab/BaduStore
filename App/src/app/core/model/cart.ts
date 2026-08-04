import { CartItem } from './cart-item';

export interface Cart {
  totalQuantity: number;
  totalAmount: number;
  items: CartItem[];
}
