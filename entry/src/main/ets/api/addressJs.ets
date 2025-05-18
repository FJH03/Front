import { requestPost, requestDelete, requestGet, requestPut } from '../models/net'

export async function addressListApi(params: object) {
  return await requestGet('/addressBook/list', params);
}

export async function addressLastUpdateApi() {
  return await requestGet('/addressBook/lastUpdate');
}

export async function addAddressApi(params: object) {
  return await requestPost('/addressBook', params);
}

export async function updateAddressApi(params: object) {
  return await requestPut('/addressBook', params);
}

export async function deleteAddressApi(params: object) {
  return await requestDelete('/addressBook', params);
}

export async function setDefaultAddressApi() {
  return await requestPut('/addressBook/default');
}

export async function getDefaultAddressApi() {
  return await requestGet('/addressBook/default');
}