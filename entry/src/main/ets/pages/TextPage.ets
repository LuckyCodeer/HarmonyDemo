
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
      RelativeContainer() {
        Text(this.message)
          .id('TextPageHelloWorld')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.black_999999'))
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(() => {
            this.message = 'Welcome';
          })

        Text('我是一个跑马灯我是一个跑马灯我是一个跑马灯我是一个跑马灯')
          .maxLines(1)
          .ellipsisMode(EllipsisMode.END)
          .textOverflow({overflow: TextOverflow.MARQUEE})
      }
      .height('100%')
      .width('100%')
    }.title("文本Text")
  }
}