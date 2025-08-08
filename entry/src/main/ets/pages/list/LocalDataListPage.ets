@Builder
export function PageBuilder() {
  LocalDataListPage();
}

@Entry
@Component
struct LocalDataListPage {
  @State listDirection?: Axis = Axis.Vertical

  build() {
    NavDestination() {
      List({ space: 10 }) {
        ListItem() {
          Text('测试0')
        }.padding(10)

        ListItem() {
          Text('测试1')
        }.padding(10)

        ListItem() {
          Text('测试2')
        }.padding(10)

        ListItem() {
          Text('测试3')
        }.padding(10)

        ListItem() {
          Text('测试4')
        }.padding(10)

        ListItem() {
          Text('测试5')
        }.padding(10)
      }.divider({ strokeWidth: 1, color: '#efefef' })
      .width('100%')
      .height('100%')
      .listDirection(this.listDirection)
    }.title('本地数据列表').onReady((context: NavDestinationContext) => {
      if (context.pathInfo.param != null) {
        this.listDirection = context.pathInfo.param as Axis
      }
    })
  }
}