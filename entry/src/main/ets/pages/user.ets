import { loginOutApi } from '../api/loginJs'

@Entry
@Component
struct user {
  build() {
    Button('登出', { type: ButtonType.Capsule })
      .width('80%')
      .height(50)
      .margin({ top: 40 })
      .onClick(() => loginOutApi())
  }
}
