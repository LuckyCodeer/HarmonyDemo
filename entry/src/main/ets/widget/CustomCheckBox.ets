/**
 * 自定义checkbox
 */
@Component
export struct CustomCheckBox {
  @Link isChecked: boolean //双向绑定
  @Prop text: string //接受调用者传递的值
  @Prop textSize: number
  @Prop textColor: ResourceColor
  onValueChange?: (value: boolean) => void //选中改变回调函数

  build() {
    Row() {
      Checkbox().select(this.isChecked)
        .onChange((checked) => {
          this.isChecked = checked
          if (this.onValueChange) {
            this.onValueChange(this.isChecked)
          }
        })
      Text(this.text).margin({ left: '5fpx' })
        .fontSize(this.textSize)
        .fontColor(this.textColor)
        .onClick(() => {
          this.isChecked = !this.isChecked
        })
    }
  }
}