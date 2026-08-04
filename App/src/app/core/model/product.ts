import { Category } from './category';
import { Brand } from './brand';
import { Image } from './image';
import { ProductAttribute } from './product-attribute';
import { Attribute } from './attribute';
import { Review } from './review';
export interface Product {
  id: number;
  categoryId: number;
  brandId: number;
  name: string;
  alias: string;
  description: string;
  price: number;
  quantity: number;
  isHot: boolean;
  isActive: boolean;
  categoryName: string;
  brandName: string;
  attributes: Attribute[];
  images: Image[];
  reviews: Review[];
  thumbURL: string;
}
