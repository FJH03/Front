export class MainAttribute implements AttributeModifier<ButtonAttribute> {
  applyNormalAttribute(instance: ButtonAttribute): void {
    instance
      .height('100%')
  }
}