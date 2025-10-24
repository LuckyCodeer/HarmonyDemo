@Builder
export function PageBuilder() {
  TabPage();
}

@Entry
@Component
struct TabPage {

  build() {
    NavDestination() {
      Tabs({
        barPosition: BarPosition.End,
      }) {
        TabContent() {
          Text('首页')
        }.tabBar({
          text: '首页',
          icon: $r('app.media.startIcon')
        })
        TabContent() {
          Text('功能')
        }.tabBar({
          text: '功能',
          icon: $r('app.media.startIcon')
        })
        TabContent() {
          Text('我的')
        }.tabBar({
          text: '我的',
          icon: $r('app.media.startIcon')
        })
      }
    }
    .height('100%')
    .width('100%')
    .title('Tab')
  }
}