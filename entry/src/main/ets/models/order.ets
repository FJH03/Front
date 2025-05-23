import { OrderItem } from "./user";

export interface OrderInfo {
  id: string;
  orderTime: string;
  status: OrderStatus;
  details: OrderItem[];
  amount: number;
  totalItems: number;
}

export type OrderStatus = 1 | 2 | 3 | 4 | 5;