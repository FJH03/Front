
import { webview } from '@kit.ArkWeb'
import { Front_URL } from '../models/net'

@Entry
@Component
struct WebContainer {
  controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Row() {
      Column() {
        Web({ src: Front_URL, controller: this.controller})
      }
      .width('100%')
    }
    .height('100%')
  }

}
