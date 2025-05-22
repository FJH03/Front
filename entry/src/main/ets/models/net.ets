import promptAction from '@ohos.promptAction'
import http from '@ohos.net.http'

export const BASE_URL = 'http://192.168.1.8:8080';

export const Front_URL = BASE_URL + '/front/page/login.html'


// 基础配置
const httpRequest = http.createHttp();

// 通用请求函数
export async function requestPost(path: string, data?: object) {
  try {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      }
    };

    if (data) {
      options.extraData = JSON.stringify(data);
    }

    const response = await httpRequest.request(
      `${BASE_URL}${path}`,
      options
    );

    if (response.responseCode === http.ResponseCode.OK) {
      return JSON.parse(response.result.toString());
    }
    throw new Error(`请求失败：${response.responseCode}`);
  } catch (error) {
    promptAction.showToast({ message: '网络请求异常', duration: 2000 });
  }
}

export async function requestDelete(path: string, data?: object) {
  try {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.DELETE
    };

    const response = await httpRequest.request(
      `${BASE_URL}${path}`,
      options
    );

    if (response.responseCode === http.ResponseCode.OK) {
      return JSON.parse(response.result.toString());
    }
    throw new Error(`请求失败：${response.responseCode}`);
  } catch (error) {
    promptAction.showToast({ message: '网络请求异常', duration: 2000 });
  }
}

export async function requestGet(path: string, data?: object) {
  try {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.GET
    };

    if ( data ) {
      options.extraData = data
    }

    const response = await httpRequest.request(
      `${BASE_URL}${path}`,
      options
    );

    if (response.responseCode === http.ResponseCode.OK) {
      return JSON.parse(response.result.toString());
    }
    throw new Error(`请求失败：${response.responseCode}`);
  } catch (error) {
    promptAction.showToast({ message: '网络请求异常', duration: 2000 });
  }
}

export async function requestPut(path: string, data?: object) {
  try {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.PUT
    };

    if ( data ) {
      options.extraData = data
    }

    const response = await httpRequest.request(
      `${BASE_URL}${path}`,
      options
    );

    if (response.responseCode === http.ResponseCode.OK) {
      return JSON.parse(response.result.toString());
    }
    throw new Error(`请求失败：${response.responseCode}`);
  } catch (error) {
    promptAction.showToast({ message: '网络请求异常', duration: 2000 });
  }
}