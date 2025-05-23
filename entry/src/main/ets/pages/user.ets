import router from '@ohos.router';
import { OrderInfo, UserInfo } from '../models/user';
import { orderAgainApi, orderPagingApi  } from '../api/orderJs'
import { loginOutApi } from '../api/loginJs'

@Entry
@Component
struct UserCenterPage {
  @State userInfo: UserInfo = {
    name: '林之迷',
    phone: '',
    gender: 'female',
    avatar: $r('app.media.user')
  };

  @State latestOrder: OrderInfo | null = null;
  @State loading: boolean = false;

  // 生命周期函数
  aboutToAppear() {
    this.loadLatestOrder();
  }

  // 构建用户信息区域
  @Builder
  private UserProfile() {
    Row() {
      Image(this.userInfo.avatar)

      Column() {
        Row() {
          Text(this.userInfo.name)
        }

        Text(this.userInfo.phone)
      }
      .margin({ left: 16 })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  // 构建功能入口
  @Builder
  private FunctionItem(icon: Resource, text: string, onClick: () => void) {
    Row() {
      Image(icon)

      Text(text)
        .layoutWeight(1)
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .onClick(onClick)
  }

  // 构建订单状态标签
  private getOrderStatus(status: number): string {
    const statusMap = new Map([
      [1, '待付款'],
      [2, '正在派送'],
      [3, '已派送'],
      [4, '已完成'],
      [5, '已取消']
    ]);
    return statusMap.get(status) || '未知状态';
  }

  build() {
    Column() {
      // 头部导航
      Row() {
        Image($r('app.media.back'))
          .onClick(() => router.back())

        Text('个人中心')
      }

      // 用户信息
      this.UserProfile()
      // 功能入口
      Column() {
        this.FunctionItem($r('app.media.location'), '地址管理',
          () => router.pushUrl({ url: 'pages/AddressPage' }))

        Divider()
          .strokeWidth(0.5)
          .color('#F0F0F0')

        this.FunctionItem($r('app.media.orders'), '历史订单',
          () => router.pushUrl({ url: 'pages/OrderListPage' }))
      }
      .margin({ top: 12 })

      // 最新订单
      if (this.latestOrder) {
        Column() {
          Row() {
            Text('最新订单')
            Text(this.latestOrder.orderTime)
            Text(this.getOrderStatus(this.latestOrder.status))
          }

          Row() {
            Text(`共${this.latestOrder.totalItems}件商品，实付`)
            Text(`￥${this.latestOrder.amount}`)
          }

          if (this.latestOrder.status === 4) {
            Button('再来一单')
              .onClick(() => this.reorder())
          }
        }
        .padding(16)
        .margin({ top: 12 })
        .backgroundColor('#FFFFFF')
      }

      // 退出登录
      Button('退出登录')
        .onClick(() => this.logout())
    }
  }

  // 加载最新订单
  private async loadLatestOrder() {
    orderPagingApi(this.userInfo);
  }

  // 重新下单
  private async reorder() {
    orderAgainApi(this.userInfo);
  }

  // 退出登录
  private async logout() {
    loginOutApi();
  }
}