import router from '@ohos.router'
import { loginOutApi } from '../api/loginJs'

@Entry
@Component
struct Index {
  @State activeType: number = 0
  @State showCartDialog: boolean = false

  // 数据加载
  private async loadData() {

  }

  // 生命周期
  aboutToAppear() {
    this.loadData()
  }

  build() {
    Column() {

    }
  }
}