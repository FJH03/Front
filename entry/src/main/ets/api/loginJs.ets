// api/login.js
import http from '@ohos.net.http'
import { LoginForm } from "../models/login"
import promptAction from '@ohos.promptAction'
import { BASE_URL } from "../models/net"

// 基础配置
const httpRequest = http.createHttp();

// 通用请求函数
async function requestPost(path: string, data?: object) {
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

export async function sendMsgApi(params: LoginForm) {
  return await requestPost('/user/sendMsg', params);
}

// 登录接口
export async function loginApi(params: LoginForm) {
  return await requestPost('/user/login', params);
}

export async function loginOutApi() {
  return await requestPost('/user/loginout');
}