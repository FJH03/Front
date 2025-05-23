import { requestPost, requestDelete, requestGet, requestPut } from '../models/net'

// 请求地址列表
export async function addressListApi() {
  return await requestGet('/addressBook/list');
}

// 添加地址
export async function addAddressApi(params: object) {
  return await requestPost('/addressBook', params);
}

/// 更新地址
export async function updateAddressApi(params: object) {
  return await requestPut('/addressBook', params);
}

// 删除地址
export async function deleteAddressApi(params: object) {
  return await requestDelete('/addressBook', params);
}

// 获取默认地址
export async function getDefaultAddressApi() {
  return await requestGet('/addressBook/default');
}