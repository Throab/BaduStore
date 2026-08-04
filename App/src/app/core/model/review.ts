export interface Review {
  id: number;
  productId: number;
  customerId: number;
  ratingValue: number;
  comment: string;
  customerName: string;
  createdAt: Date;
}
