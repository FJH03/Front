// api/login.js
import { LoginForm } from "../models/login"
import { requestPost } from "../models/net"

// 发送短信验证码
export async function sendMsgApi(params: LoginForm) {
  return await requestPost('/user/sendMsg', params);
}

// 登录接口
export async function loginApi(params: LoginForm) {
  return await requestPost('/user/login', params);
}

// 登出接口
export async function loginOutApi() {
  return await requestPost('/user/loginout');
}