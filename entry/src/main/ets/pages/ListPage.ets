@Builder
function PageBuilder() {
  ListPage();
}

@Component
export struct ListPage {
  pageStack?: NavPathStack

  build() {
    NavDestination() {
      Column({ space: '10fp' }) {
        Button('本地数据列表')
          .onClick(() => {
            this.pageStack?.pushDestinationByName("LocalDataListPage", "", true);
          })

        Button('接口数据列表')
          .onClick(() => {
            this.pageStack?.pushDestinationByName("NetListPage", "", true);
          })

        Button('宫格数据列表')
          .onClick(() => {
            this.pageStack?.pushDestinationByName("GridListPage", "", true);
          })

        Button('横向数据列表')
          .onClick(() => {
            this.pageStack?.pushDestinationByName("LocalDataListPage", Axis.Horizontal, true);
          })

        Button('下拉刷新上拉加载更多')
          .onClick(() => {
            this.pageStack?.pushDestinationByName("RefreshLoadMoreListPage", '', true);
          })
      }
    }.title('列表')
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack;
    })
  }

}