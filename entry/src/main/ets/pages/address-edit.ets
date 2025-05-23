import { router } from '@kit.ArkUI';
import prompt from '@ohos.prompt';
import { AddressItem } from '../models/AddressPage';
import { ValidateUtil } from '../utils/ValidateUtil';
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
  }

  // 构建表单项
  @Builder
  private FormItem(title: string, _content: () => void) {
    Row() {
      Text(title)
        .fontSize(18)
    }
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
      Scroll() {
        Column() {
          // 联系人输入
          this.FormItem('联系人：', () => {
            TextInput({ text: this.form.consignee })
              .onChange(value => this.form.consignee = value)
          })

          // 手机号输入
          this.FormItem('手机号：', () => {
            TextInput({ text: this.form.phone })
              .maxLength(11)
              .onChange(value => this.form.phone = value)
          })

          // 地址输入
          this.FormItem('地址：', () => {
            TextInput({ text: this.form.detail })
              .maxLength(140)
              .onChange(value => this.form.detail = value)
          })

        }
        .padding(16)
      }

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
    if (!ValidateUtil.validateName(this.form.consignee)) {
      return prompt.showToast({ message: '请输入有效联系人' });
    }
    if (!ValidateUtil.validatePhone(this.form.phone)) {
      return prompt.showToast({ message: '手机号格式不正确' });
    }
    if (!this.form.detail) {
      return prompt.showToast({ message: '请输入详细地址' });
    }

    try {
      updateAddressApi(this.form)
    } catch (error) {
      prompt.showToast({ message: '保存失败，请重试' });
      addAddressApi(this.form)
    } finally {
      router.replaceUrl({ url: 'pages/AddressPage' });
    }
  }
}