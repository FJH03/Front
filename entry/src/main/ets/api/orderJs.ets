import { requestPost, requestGet } from '../models/net'

export async function addOrderApi(params: object) {
  return await requestPost('/order/submit', params);
}

export async function orderListApi() {
  return await requestGet('/order/list');
}

export async function orderPagingApi(params: object) {
  return await requestGet('/order/userPage', params);
}

export async function orderAgainApi(params: object) {
  return await requestPost('/order/userPage', params);
}
