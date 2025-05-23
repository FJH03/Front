import { requestPost, requestGet } from '../models/net'

// 提交订单
export async function addOrderApi(params: object) {
  return await requestPost('/order/submit', params);
}

// 用户端获取自身订单信息
export async function orderPagingApi(params: object) {
  return await requestGet('/order/userPage', params);
}

// 再来一单
export async function orderAgainApi(params: object) {
  return await requestPost('/order/userPage', params);
}
