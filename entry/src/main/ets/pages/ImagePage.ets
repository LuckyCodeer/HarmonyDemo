@Builder
export function PageBuilder() {
  ImagePage();
}

@Entry
@Component
struct ImagePage {
  scroller: Scroller = new Scroller()

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column({ space: 15 }) {
          Text("默认")
          Image($r('app.media.bg2'))
            .width(200)
            .height(200)

          Text("Cover")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.Cover)
            .width(200)
            .height(200)

          Text("Fill")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.Fill)
            .width(200)
            .height(200)

          Text("None")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.None)
            .width(200)
            .height(200)

          Text("Contain")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.Contain)
            .width(200)
            .height(200)

          Text("Auto")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.Auto)
            .width(200)
            .height(200)

          Text("ScaleDown")
          Image($r('app.media.bg2'))
            .objectFit(ImageFit.ScaleDown)
            .width(200)
            .height(200)
        }
      }.scrollable(ScrollDirection.Vertical)
      .width('100%')
      .height('100%')
    }.title('图片组件')
  }
}