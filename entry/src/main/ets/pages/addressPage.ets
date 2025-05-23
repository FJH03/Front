import router from '@ohos.router';
import { AddressItem } from '../models/AddressPage';
import { addressListApi } from '../api/addressJs'

@Entry
@Component
struct AddressManagePage {
  @State addressList: AddressItem[] = [];
  @State selectedId: string = '';

  // 生命周期函数 - 初始化数据
  aboutToAppear() {
    addressListApi()
  }


  // 设置默认地址
  private async setDefaultAddress(item: AddressItem) {
    try {
      addressListApi();
    } catch (error) {
      console.error('设置默认地址失败:', error);
    }
  }

  build() {
    Column() {
      // 头部导航
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 12 })
          .onClick(() => router.back());

        Text('地址管理')
          .fontSize(20)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#ffffff')

      // 地址列表
      Scroll() {
        Column() {
          ForEach(this.addressList, (item: AddressItem) => {
            Column() {
              // 地址信息
              Row() {
                // 地址标签
                Text(item.label)
                  .fontSize(12)
                  .padding(4)
                  .fontColor('#ffffff')
                  .borderRadius(4)

                Text(item.detail)
                  .fontSize(14)
                  .margin({ left: 8 })
                  .layoutWeight(1)
              }
              .margin({ top: 12 })

              // 用户信息
              Row() {
                Text(`${item.consignee}${item.sex === '0' ? '女士' : '先生'}`).fontSize(12).fontColor('#666666')
                Text(item.phone).margin({ left: 12 }).fontSize(12).fontColor('#666666')
              }
              .margin({ top: 8 })

              // 操作区域
              Row() {
                Image($r('app.media.edit'))
                  .width(20)
                  .height(20)
                  .onClick(() => this.navigateToEdit(item))

                Row() {
                  if (item.isDefault === 1) {
                    Image($r('app.media.checked_true'))
                      .width(18)
                      .height(18)
                  } else {
                    Image($r('app.media.checked_false'))
                      .width(18)
                      .height(18)
                      .onClick(() => this.setDefaultAddress(item))
                  }
                  Text('默认地址').margin({ left: 4 })
                }
                .margin({ left: 16 })
              }
              .margin({ top: 12 })
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Divider()
                .strokeWidth(0.5)
                .color('#eeeeee')
                .margin(12)
            }
            .padding(16)
            .backgroundColor('#ffffff')
            .margin({ top: 8 })
            .onClick(() => this.handleItemClick(item))
          })
        }
      }
      .layoutWeight(1)

      // 底部添加按钮
      Button('+ 添加收货地址')
        .width('90%')
        .height(40)
        .backgroundColor('#1890ff')
        .fontColor('#ffffff')
        .margin(16)
        .onClick(() => this.navigateToEdit())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  // 跳转编辑页面
  private navigateToEdit(item?: AddressItem) {
    router.pushUrl({
      url: 'pages/AddressEditPage',
      params: item
    });
  }

  // 处理地址项点击
  private handleItemClick(item: AddressItem) {
    if (router.getState()) {
      this.setDefaultAddress(item);
      router.back();
    }
  }
}