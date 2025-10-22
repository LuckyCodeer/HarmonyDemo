
// 跳转页面入口函数
@Builder
export function PageBuilder() {
  TextPage();
}

@Entry
@Component
struct TextPage {
  @State message: string = 'Hello World';
  pageStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column({space: 15}) {
        Text(this.message)
          .id('TextPageHelloWorld')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.black_999999'))
          .onClick(() => {
            this.message = 'Welcome';
          })

        Text('我是一个跑马灯我是一个跑马灯我是一个跑马灯我是一个跑马灯')
          .maxLines(1)
          .ellipsisMode(EllipsisMode.END)
          .textOverflow({overflow: TextOverflow.MARQUEE})

        Row() {
          Checkbox()
          Text('富文本') {
            Span('请阅读并同意')
            Span('《用户协议》').fontColor(Color.Orange)
              .onClick(() => {
                this.getUIContext().getPromptAction().showToast({
                  message: '点击了用户协议'
                })
              })
          }.padding({right: 20})
        }.margin({top: 20}).width('100%')

        Hyperlink('https://baidu.com', "我是一个超链接")
          .color(Color.Green)

      }
      .height('100%')
      .width('100%')
    }.title("文本Text")
  }
}