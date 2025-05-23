
export class ValidateUtil {
  // 姓名验证（支持中文名）
  static validateName(name: string): boolean {
    return /^[\u4e00-\u9fa5]{2,10}$/.test(name);
  }

  // 手机号验证
  static validatePhone(phone: string): boolean {
    return /^1[3-9]\d{9}$/.test(phone);
  }

  // 地址验证
  static validateAddress(address: string): boolean {
    return address.length >= 5 && address.length <= 140;
  }
}