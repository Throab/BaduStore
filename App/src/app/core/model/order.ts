import { OrderItem } from './order-item';

export interface Order {
  id: number;
  userId: number;
  orderTotal: number;
  status: string;
  paymentMethod: string;
  address: string;
  phoneNumber: string;
  createdAt: Date;
  orderItems: OrderItem[];
}
