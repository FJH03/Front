import { requestPost, requestDelete, requestGet } from '../models/net'

export async function addCartApi(params: object) {
  return await requestPost('/shoppingCart/add', params);
}

export async function clearCartApi() {
  return await requestDelete('/shoppingCart/clean');
}

export async function updateCartApi(params: object) {
  return await requestPost('/shoppingCart/sub', params);
}

export async function setMealDishDetailsApi(params: object) {
  return await requestGet('/shoppingCart/sub', params);
}


