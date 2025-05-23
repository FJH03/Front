import { requestPost, requestDelete, requestGet } from '../models/net'

// 添加购物车
export async function addCartApi(params: object) {
  return await requestPost('/shoppingCart/add', params);
}

// 清空购物车
export async function clearCartApi() {
  return await requestDelete('/shoppingCart/clean');
}

// 更新购物车
export async function updateCartApi(params: object) {
  return await requestPost('/shoppingCart/sub', params);
}

// 设置餐品口味
export async function setMealDishDetailsApi(params: object) {
  return await requestGet('/shoppingCart/sub', params);
}


