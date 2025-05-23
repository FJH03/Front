import { requestPost, requestDelete } from '../models/net'

// 添加购物车
export async function addCartApi(params: object) {
  return await requestPost('/shoppingCart/add', params);
}

// 清空购物车
export async function clearCartApi() {
  return await requestDelete('/shoppingCart/clean');
}




