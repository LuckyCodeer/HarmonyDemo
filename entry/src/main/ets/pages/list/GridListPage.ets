import { PromptAction, promptAction } from "@kit.ArkUI";

@Builder
export function PageBuilder() {
  GridListPage();
}

@Entry
@Component
struct GridListPage {
  dataList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
  private scroller: Scroller = new Scroller();
  uiContext: UIContext = this.getUIContext();
  promptAction: PromptAction = this.uiContext.getPromptAction();

  build() {
      NavDestination() {
      Grid(this.scroller) {
        ForEach(this.dataList, (item: string) => {
          GridItem() {
            Text(item)
          }.padding(20).backgroundColor(Color.Red)
          .width('30%')
          .onClick((event) => {
            promptAction.showToast({
              message: '点击了' + item
            })
          })
        })
      }.maxCount(3)
      .columnsGap(10) //列间距
      .rowsGap(10) //行间距
      .width('100%')
      .height('100%')
    }.title('宫格列表')
  }
}