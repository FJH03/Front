// OrderListPage.ets
import router from '@ohos.router';
import { OrderInfo } from '../models/order';

@Entry
@Component
struct OrderListPage {
  @State orderList: OrderInfo[] = [];
  @State loading: boolean = false;
  @State finished: boolean = false;
  @State page: number = 1;

  build() {
    Column() {
      Column() {
        // 订单合计
        Row() {
          Text(`共${Number}件商品`)
        }
        .margin({ top: 8 })

      }
      .padding(16)
      .backgroundColor('#FFFFFF')
      .margin({ top: 8 })
      // 头部导航
      Row() {
        Image($r('app.media.back'))
          .onClick(() => router.back())

        Text('订单列表')

      }

      // 订单列表
      Scroll() {
        if (this.orderList.length === 0) {
          this.EmptyState()

        }
      }
      .scrollBar(BarState.Off)
    }
  }

  // 空状态
  @Builder
  EmptyState() {
    Column() {
      Image($r('app.media.no_order'))
        .width(200)
        .height(200)

      Text('暂无订单')
        .margin({ top: 16 })
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  // 初始化数据
  aboutToAppear() {
    this.loadOrders();
  }

  // 加载订单
  private async loadOrders() {
    if (this.finished || this.loading) return;

    this.loading = true;

    OrderListPage();
  }
}