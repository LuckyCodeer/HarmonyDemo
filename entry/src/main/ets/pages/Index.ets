import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack) {
      Column({space: '15fp'}) {
        Button('文本组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("TextPage", "", true).catch((error: BusinessError) => {
              console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
            }).then(() => {
              console.info('Push destination succeed.');
            });
          })

        Button('输入组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("InputPage", "", true);
          })

        Button('图片组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("ImagePage", "", true);
          })

        Button('选择组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("CheckPage", "", true);
          })

        Button('列表组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("ListPage", "", true);
          })

        Button('弹框')
          .onClick(() => {
            this.pageStack.pushDestinationByName("DialogPage", "", true);
          })

        Button('自定义组件')
          .onClick(() => {
            this.pageStack.pushDestinationByName("CustomWidgetPage", "", true);
          })
      }
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }.title("组件演示")
  }
}