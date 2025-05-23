// model/CommonTypes.ets
interface az {
  latitude: number;
  longitude: number;
}

export interface AddressItem {
  id: string;          // 地址唯一标识
  label: string;       // 地址标签：'家' | '公司' | '学校' | 其他自定义
  detail: string;      // 详细地址
  consignee: string;   // 收件人姓名
  sex: string;         // 性别：'0'-女士，'1'-先生
  phone: string;       // 联系电话
  isDefault: number;   // 是否默认地址：0-否，1-是
  coordinate?: az;
  postalCode?: string; // 可选字段：邮政编码
}

// 建议添加配套的API响应结构
export interface AddressListResponse {
  code: number;
  msg: string;
  data: AddressItem[];
}

export interface DefaultAddressRequest {
  id: string;  // 要设置的地址ID
}