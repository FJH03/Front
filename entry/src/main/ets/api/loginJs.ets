// api/login.js
import { LoginForm } from "../models/login"
import { requestPost } from "../models/net"

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