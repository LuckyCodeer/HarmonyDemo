import { CustomCheckBox } from "../widget/CustomCheckBox"

@Builder
export function PageBuilder() {
  CustomWidgetPage()
}

@Entry
@Component
struct CustomWidgetPage {
  @State isChecked: boolean = false
  @State textValue: string = ''

  build() {
    NavDestination() {
      Column() {
        Text(this.textValue)
        CustomCheckBox({
          text: '测试选项',
          isChecked: $isChecked,
          textSize: 20,
          textColor: Color.Red,
          onValueChange: (isChecked) => {
            this.textValue = isChecked ? "选中" : "未选中"
          }
        })
      }
    }
    .title('自定义组件')
  }
}