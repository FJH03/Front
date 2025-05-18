import router from '@ohos.router';
import { loginApi, sendMsgApi } from '../api/loginJs';
import promptAction from '@ohos.promptAction';
import { LoginForm, token } from '../models/login';
import { font } from '@kit.ArkUI';

interface ApiResponse<T = void> {
  code: number;
  data?: T;
  msg?: string;
}

@Entry
@Component
struct login {
  @State form: LoginForm = { phone: '', code: '' }
  @State msgFlag: boolean = false
  @State loading: boolean = false

  aboutToAppear() {
    font.registerFont({
      familyName: 'PingFangSC-Regular', // 注册的字体名称
      familySrc: '/fonts/PingFangSC-Regular.ttf' // font文件夹与pages目录同级
    })
  }

  build() {
    Column() {
      // 头部标题
      Text('登录')
        .fontSize(18)
        .fontWeight(500)
        .lineHeight(88)
        .fontColor('#ffffff')
        .margin({ top: 40, bottom: 40 })
        .opacity(1)
        .textAlign(TextAlign.Center)
        .fontFamily('PingFangSC-Regular')
        .backgroundColor('#333333')
        .width('100%')

      // 输入区域
      Column() {
        Row() {
          TextInput({ placeholder: '请输入手机号码' })
            .width('80%')
            .height(50)
            .maxLength(20)
            .type(InputType.Normal)
            .placeholderFont({ size: 16 })
            .onChange((value: string) => {
              this.form.phone = value
            })

          Text('获取验证码')
            .fontSize(14)
            .fontColor('#007AFF')
            .margin({ top: 10 })
            .onClick(() => this.getCode())
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)


        Divider().color('#eeeeee').margin({ top: 10, bottom: 10 })

        TextInput({ placeholder: '请输入验证码' })
          .width('90%')
          .height(50)
          .type(InputType.Number)
          .placeholderFont({ size: 16 })
          .onChange((value: string) => {
            this.form.code = value
          })
      }
      .width('100%')

      // 错误提示
      if (this.msgFlag) {
        Text('手机号输入不正确，请重新输入')
          .fontSize(12)
          .fontColor('#FF0000')
          .margin({ top: 10 })
      }

      // 登录按钮
      Button('登录', { type: ButtonType.Capsule })
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .backgroundColor(this.form.phone && this.form.code ? '#007AFF' : '#CCCCCC')
        .onClick(() => this.btnLogin())
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  // 获取验证码
  private async getCode() {
    const regex = /^(13[0-9]{9})|(15[0-9]{9})|(17[0-9]{9})|(18[0-9]{9})|(19[0-9]{9})$/;
    if (regex.test(this.form.phone)) {
      this.msgFlag = false
      sendMsgApi({
        phone: this.form.phone,
        code: this.form.code
      })
    } else {
      this.msgFlag = true
    }
  }

  private async btnLogin() {
    if (this.form.phone && this.form.code) {
      this.loading = true
      try {
        const res: ApiResponse<token> = await loginApi(this.form)
        if (res.code === 1) {
          // 存储用户信息
          AppStorage.setOrCreate('userPhone', this.form.phone)
          // 跳转首页
          router.pushUrl({ url: 'pages/index' })
        } else {
          promptAction.showToast({ message: res.msg, duration: 2000 })
        }
      } catch (e) {
        promptAction.showToast({ message: '网络请求失败', duration: 2000 })
      } finally {
        this.loading = false
      }
    } else {
      promptAction.showToast({ message: '请输入手机号码', duration: 2000 })
    }
  }
}