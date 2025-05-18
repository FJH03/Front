export interface  CategoryItem {
  id: number
  name: string
  type: number
}

export interface DishItem {
  id: number
  name: string
  price: number
  description: string
  image: string
  number: number
}

export interface DetailsDialog {
  show: boolean
  item?: DishItem
}