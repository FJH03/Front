// model/UserTypes.ets
export interface UserInfo {
  avatar: Resource;
  name: string;
  phone: string;
  gender: 'male' | 'female';
}

export interface OrderInfo {
  id: string;
  orderTime: string;
  status: number;
  details: OrderItem[];
  amount: number;
  totalItems: number;
}

export interface OrderItem {
  name: string;
  quantity: number;
  price: number;
}