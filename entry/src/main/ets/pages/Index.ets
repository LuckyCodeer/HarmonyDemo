import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack) {
      Column({ space: '15fp' }) {
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

        Button('轮播图')
          .onClick(() => {
            this.pageStack.pushDestinationByName("BannerPage", "", true);
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

        Button('其他API')
          .onClick(() => {
            this.pageStack.pushDestinationByName("ApiPage", "", true);
          })
      }
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }
    .title("组件演示")
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
    .menus([{
      value: '菜单1',
      icon: $r('app.media.startIcon'),
    }, {
      value: '菜单2',
      icon: $r('app.media.startIcon'),
    }, {
      value: '菜单3',
      icon: $r('app.media.startIcon'),
    }, {
      value: '菜单4',
      icon: $r('app.media.startIcon'),
    }])
  }
}