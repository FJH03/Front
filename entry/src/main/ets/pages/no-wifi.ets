import router from '@ohos.router';

@Entry
@Component
struct NoNetworkPage {
  build() {
    Column() {
      // 头部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 12 })
          .onClick(() => this.goBack())

        Text('Time-Corner')
          .fontSize(20)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#ffffff')

      // 内容区域
      Column() {
        Image($r('app.media.no_wifi'))
          .width(200)
          .height(200)
          .margin({ top: 80 })

        Text('网络连接异常')
          .fontSize(18)
          .margin({ top: 20 })
          .fontColor('#666666')

        Button('点击刷新')
          .width(120)
          .height(40)
          .margin({ top: 30 })
          .backgroundColor('#1890ff')
          .fontColor('#ffffff')
          .onClick(() => this.refreshPage())
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  // 返回上一页
  private goBack() {
    router.back();
  }

  // 刷新页面
  private refreshPage() {
    // 简单实现返回上一页
    router.back();
  }
}