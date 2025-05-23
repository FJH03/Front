import { router } from '@kit.ArkUI';
import { AddressItem } from '../models/AddressPage';
import { addressListApi, updateAddressApi, deleteAddressApi, addAddressApi } from '../api/addressJs'

@Entry
@Component
struct AddressEditPage {
  @State form: AddressItem = {
    consignee: '',
    phone: '',
    sex: '1',
    detail: '',
    label: '无',
    isDefault: 0,
    id: ''
  };
  @State labelList: string[] = ['无', '公司', '家', '学校'];
  @State activeLabelIndex: number = 0;
  @State editMode: boolean = false;

  aboutToAppear() {
    addressListApi();
    this.GenderSelector();
  }

  // 构建性别选择
  @Builder
  private GenderSelector() {
    Row() {
      Radio({ value: '1', group: 'gender' })
        .checked(this.form.sex === '1')
        .onChange(checked => checked && (this.form.sex = '1'))

      Text('先生')
        .margin({ left: 8 })

      Radio({ value: '0', group: 'gender' })
        .checked(this.form.sex === '0')
        .onChange(checked => checked && (this.form.sex = '0'))
        .margin({ left: 24 })

      Text('女士')
        .margin({ left: 8 })
    }
  }

  build() {
    Column() {

      // 操作按钮
      Column() {
        Button(this.editMode ? '保存修改' : '保存地址')
          .onClick(() => this.validateAndSubmit())

        if (this.editMode) {
          Button('删除地址')
            .margin({ top: 12 })
            .onClick(() => this.showDeleteConfirm())
        }
      }
      .width('100%')
      .padding(16)
    }
  }

  showDeleteConfirm(): void {
    deleteAddressApi(this.form);
  }

  // 验证并提交表单
  private async validateAndSubmit() {
    try {
      updateAddressApi(this.form)
    } catch (error) {
      addAddressApi(this.form)
    } finally {
      router.replaceUrl({ url: 'pages/AddressPage' });
    }
  }
}