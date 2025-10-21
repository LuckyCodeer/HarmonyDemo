@Builder
export function PageBuilder() {
  BannerPage();
}

@Entry
@Component
struct BannerPage {
  private imageUrls = ['https://pic.rmb.bdstatic.com/bjh/bc196d85d67/250808/d38b32c34076ebaf42a3a97cbe596489.png',
    'https://img2.baidu.com/it/u=763738751,3371620803&fm=253&app=120&f=JPEG?w=1422&h=800',
    'https://img0.baidu.com/it/u=2909333818,2097436914&fm=253&app=120&f=JPEG?w=1422&h=800',
    'https://img1.baidu.com/it/u=226328954,1411113403&fm=253&app=120&f=JPEG?w=1422&h=800']

  build() {
    NavDestination() {
      Column() {
        Swiper() {
          Text('测试1111111111111111111111').fontColor(Color.White)
          Text('测试2222222222222222222222').fontColor(Color.White)
        }
        .width('100%')
        .padding(10)
        .autoPlay(true)
        .interval(3000)
        .indicator(false)
        .loop(true)
        .backgroundColor(Color.Orange)
        .borderRadius(5)

        Swiper() {
          ForEach(this.imageUrls, (value: string, position: number) => {
            Image(value).objectFit(ImageFit.Cover)
          })
        }.borderRadius(5)
        .autoPlay(true)
        .loop(true)
        .margin({top: 20})
        .width('100%')
        .height('30%')
      }
    }
    .height('100%')
    .width('100%')
    .padding(20)
    .title('Banner')
  }
}