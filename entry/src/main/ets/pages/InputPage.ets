import { LengthMetrics } from '@kit.ArkUI';

@Builder
export function PageBuilder() {
  InputPage();
}

@Entry
@Component
struct InputPage {
  @State message: string = 'Hello World';

  build() {
    NavDestination() {
      Column() {
        Text('普通输入框')
        TextInput({text: '', placeholder: '请输入内容'})
          .fontSize('15fp')
          .fontColor(Color.Black)
          .margin({top: '10fp'})
          .width('100%')

        Text('密码输入框')
          .margin({top: '15fp'})
        TextInput({text: '', placeholder: '请输入密码'})
          .fontSize('15fp')
          .fontColor(Color.Black)
          .margin({top: '10fp'})
          .type(InputType.Password)
          .width('100%')

        Text('带清除内容的输入框')
          .margin({top: '15fp'})
        TextInput({text: '', placeholder: '请输入密码'})
          .fontSize('15fp')
          .fontColor(Color.Black)
          .margin({top: '10fp'})
          .cancelButton({icon: {
            src: $r('app.media.input_clear')
          }})
          .width('100%')

        Text('文本域')
          .margin({top: '15fp'})
        TextArea({placeholder: '请输入文本内容'})
          .fontColor(Color.Black)
          .fontSize('15fp')
          .maxLines(10)
          .lineSpacing(LengthMetrics.fp(10))
          .showCounter(true)
          .maxLength(100)
          .margin({top: '10fp'})
          .height('150fp')

        Text('左侧带图标')
          .margin({top: '15fp'})
        Row() {
          Image($r('app.media.startIcon'))
            .width('16fp').height('16fp')
          TextInput({text: '', placeholder: '请输入内容'})
            .fontSize('15fp')
            .fontColor(Color.Black)
            .cancelButton({icon: {
              src: $r('app.media.input_clear')
            }})
            .backgroundColor(Color.Transparent)
        }.width('100%')
        .backgroundColor('#F3F3F3')
        .borderRadius('30fp')
        .alignItems(VerticalAlign.Center)
        .padding({left: '16fp', right: '16fp'})
        .margin({top: '10fp'})
      }
      .alignItems(HorizontalAlign.Start)
      .padding({left: '10fp', right: '10fp'})
      .height('100%')
      .width('100%')
    }.title("输入组件")
  }
}