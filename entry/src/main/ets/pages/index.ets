import router from '@ohos.router'
import { CategoryItem, DishItem, DetailsDialog } from '../models/index'
import { clearCartApi } from '../api/mainJs'
import { font } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State activeType: number = 0
  @State categoryList: Array<CategoryItem> = []
  @State dishList: Array<DishItem> = []
  @State cartDialogShow: boolean = false
  @State detailsDialog: DetailsDialog = { show: false }

  aboutToAppear() {
    font.registerFont({
      familyName: 'PingFangSC-Regular', // 注册的字体名称
      familySrc: '/fonts/PingFangSC-Regular.ttf' // font文件夹与pages目录同级
    })
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.mainBg'))
          .objectFit(ImageFit.Auto)
          .width(('100%'))
          .height(152)

        // 用户图标
        Image($r('app.media.user'))
          .width(28)
          .height(28)
          .position({ x: 19, y: 41 })
          .objectRepeat(0)
          .onClick(() => {
            router.pushUrl({ url: 'pages/user' })
          })
      }
      .height(152)
      .width('100%')

      Column() {
        Row() {
          Image($r('app.media.logo'))
            .width(39)
            .height(39)
            .opacity(1)
            .backgroundColor('#333333')
            .margin({ right: 10 })

          Column() {
            Text('菩提阁餐厅')
              .fontSize(11)
              .fontFamily('PingFangSC-Regular')
              .fontWeight(400)
              .opacity(1)
              .fontColor('#333333')

            Row() {
              this.buildInfoItem($r('app.media.time'), '距离1.5km')
              this.buildInfoItem($r('app.media.money'), '配送费6元')
              this.buildInfoItem($r('app.media.location'), '预计时长12min')
            }
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width(345)
        .height(118)
        .opacity(1)
        .backgroundColor('#ffffff')
        .borderRadius(6)
        .position({ x: 10, y: 70 })
        .margin({ left: -172.5 })
        .padding(14)
        .size({ width:'100%' })

        Text('简介: 菩提阁中餐厅是菩提阁点餐的独立的品牌，定位“大众 化的美食外送餐饮”，旨为顾客打造专业美食。')
          .fontSize(11)
          .fontFamily('PingFangSC-Regular')
          .fontWeight(400)
          .opacity(1)
          .fontColor('#333333')

        Button('测试清空购物车', { type: ButtonType.Capsule })
          .width('80%')
          .height(50)
          .margin({ top: 40 })
          .onClick(() => clearCartApi())
      }
    }
    .height('100%')
  }

  @Builder
  buildInfoItem(icon: Resource, text: string) {
    Row() {
      Image(icon)
        .width(14)
        .height(14)
        .margin({ right: 4 })

      Text(text)
        .fontSize(11)
        .fontColor('#333')
    }
    .margin({ right: 12 })
  }

  // 方法实现
  private categoryClick(index: number) {
    this.activeType = index
    // 更新dishList逻辑...
  }
}

// DishItem组件
@Component
struct DishItemView {
  @Prop item: DishItem

  build() {
    Row() {
      Image(this.item.image)
        .width(80)
        .height(80)

      Column() {
        Text(this.item.name)
        Text(this.item.description)
        Row() {
          Text(`￥${this.item.price}`)
          // 加减按钮
          CounterView({ count: this.item.number })
        }
      }
    }
  }
}

// 计数器组件
@Component
struct CounterView {
  @Prop count: number

  build() {
    Row() {
      if (this.count > 0) {
        Image($r('app.media.subtract'))
          //.onClick(() => this.subtract())
      }
      Text(this.count.toString())
      Image($r('app.media.add'))
        //.onClick(() => this.add())
    }
  }
}