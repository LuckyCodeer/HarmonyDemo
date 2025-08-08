import { webview } from "@kit.ArkWeb";
import { Website } from "../../entity/Website";

@Builder
export function PageBuilder() {
  WebPage();
}
/**
 * 浏览器页面
 */
@Entry
@Component
struct WebPage {
  @State title?: string = ''
  @State url?: string = ''
  @State progress: number = 0
  @State progressVisibility: boolean = true
  private webviewController: WebviewController = new webview.WebviewController()

  build() {
    NavDestination() {
      Column() {
        Progress({ value: this.progress, total: 100 })
          .visibility(this.progressVisibility ? Visibility.Visible : Visibility.None)
          .height('2fp')
        Web({
          src: this.url,
          controller: this.webviewController,
          renderMode: RenderMode.ASYNC_RENDER // 设置渲染模式
        }).onPageBegin((callback) => {
          console.log("================onPageBegin================")
        }).onPageEnd((callback) => {
          console.log("================onPageEnd================")
          this.progressVisibility = false
        }).onProgressChange((callback) => {
          console.log("================onProgressChange================" + callback.newProgress)
          this.progress = callback.newProgress
        })
      }.width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }.title(this.title)
    .onReady((context: NavDestinationContext) => {
      let website: Website = context.pathInfo.param as Website
      this.title = website.name
      this.url = website.link
    })
    .onBackPressed(() => {
      console.log("================onBackPressed================")
      if (this.webviewController.accessBackward()) {
        this.webviewController.backward()
        return true
      }
      return false
    })
  }
}