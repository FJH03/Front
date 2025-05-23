export interface Address {
  id?: string;
  consignee: string;
  phone: string;
  detail: string;
  sex: string;
}

export interface CartItem {
  id: string;
  name: string;
  image: string;
  number: number;
  amount: number;
}