@Builder
export function PageBuilder() {
  MediaPage();
}

@Entry
@Component
struct MediaPage {

  build() {
    NavDestination() {
      Column() {
        Text('视频组件')
        Video({
          src: 'https://www.w3school.com.cn/example/html5/mov_bbb.mp4', //视频地址
          previewUri: 'https://img1.baidu.com/it/u=226328954,1411113403&fm=253&app=120&f=JPEG?w=1422&h=800', //预览图地址
        }).height('30%')
          .controls(true) //控制UI是否显示
      }
    }
    .height('100%')
    .width('100%')
    .title('媒体组件')
  }
}