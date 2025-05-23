import router from '@ohos.router'
import { Address, CartItem } from '../models/add-order'
import { getDefaultAddressApi } from '../api/addressJs'
import { clearCartApi } from  '../api/mainJs'
import { addOrderApi } from '../api/orderJs'

@Entry
@Component
struct AddOrderPage {
  @State address: Address = {
    phone: '',
    consignee: '',
    detail: '',
    sex: '1',
    id: undefined
  };
  @State finishTime: string = '';
  @State cartData: CartItem[] = [];
  @State note: string = '';

  private getGoodsNum(): string | number {
    let num = this.cartData.reduce((sum, item) => sum + item.number, 0);
    return num > 99 ? '99+' : num;
  }

  private getGoodsPrice(): number {
    return this.cartData.reduce((sum, item) => sum + (item.number * item.amount), 0);
  }

  aboutToAppear() {
    this.initData();
  }

  private initData() {
    getDefaultAddressApi();
    clearCartApi();
    this.getFinishTime();
  }

  private getFinishTime() {
    let now = new Date();
    now.setHours(now.getHours() + 1);
    this.finishTime = `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
  }

  build() {
    Row() {
      Image($r('app.media.back'))
        .width(24)
        .height(24)
        .margin({ left: 12 })
        .onClick(() => router.back());

      Text('Time-Corner')
        .fontSize(20)
        .margin({ left: 16 })

      Scroll() {
        Column() {
          Column() {
            Column()
              .width('90%')
              .height(1)
              .backgroundColor('#eeeeee')

            Column() {
              Text(this.address.detail)
                .fontSize(16)
                .margin({ bottom: 8 })

              Row() {
                Text(`${this.address.consignee}${this.address.sex === '1' ? '先生' : '女士'}`)
                Text(this.address.phone).margin({ left: 12 })
              }
            }
            .padding(12).onClick(() => router.pushUrl({ url: 'pages/AddressPage' }))

            Text(`预计${this.finishTime}送达`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 8, bottom: 8 })
          }
          .backgroundColor('#ffffff')
          .margin({ top: 8 })

          Column() {
            Text('订单明细').fontSize(16).margin(12)
            Column().width('100%').height(1).backgroundColor('#eeeeee')

            ForEach(this.cartData, (item: CartItem, index) => {
              Row() {
                Image($r('app.media.cart'))
                  .width(60)
                  .height(60)
                  .margin(8)
                  .onError(() => {
                    //todo: 我觉得不需要
                  })

                Column() {
                  Text(item.name).fontSize(14)
                  Row() {
                    Text(`x${item.number}`).fontSize(12)
                    Text(`￥${item.amount}`)
                      .fontSize(14)
                      .fontColor('#ff5500')
                      .margin({ left: 16 })
                  }
                }
                .margin({ left: 8 })
              }
            })
          }
          .backgroundColor('#ffffff')
          .margin({ top: 8 })

          // 备注输入
          Column() {
            Text('备注').fontSize(16).margin(12)
            TextInput({ text: this.note, placeholder: '请输入您需要备注的信息' })
              .height(80)
              .maxLength(50)
              .onChange(value => this.note = value)
          }
          .backgroundColor('#ffffff')
          .margin({ top: 8 })

          // 底部支付栏
          Row() {
            Image(this.cartData.length > 0 ? $r('app.media.cart_active') : $r('app.media.cart'))
              .width(32)
              .height(32)

            if (this.cartData.length > 0) {
              Text(this.getGoodsNum().toString())
                .fontSize(12)
                .fontColor('#ffffff')
                .backgroundColor('#ff5500')
                .borderRadius(8)
                .padding(4)
            }

            Column() {
              Text(`￥${this.getGoodsPrice().toFixed(2)}`)
                .fontSize(18)
                .fontColor('#ff5500')
            }
            .layoutWeight(1)
            .margin({ left: 16 })

            Button('去支付')
              .backgroundColor(this.cartData.length > 0 ? '#ff5500' : '#cccccc')
              .onClick(() => addOrderApi(this.cartData))
          }
          .width('100%')
          .height(60)
          .padding(12)
          .backgroundColor('#ffffff')
        }
      }
    }
    .width('100%')
    .height(56)
    .backgroundColor('#ffffff')
  }
}