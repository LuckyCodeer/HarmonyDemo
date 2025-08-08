import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';
import { Website } from '../../entity/Website';

@Builder
export function PageBuilder() {
  NetListPage()
}

@Entry
@Component
struct NetListPage {
  @State websiteList: Array<Website> = new Array<Website>()
  pageStack?: NavPathStack

  build() {
    NavDestination() {
      Column() {
        List({ space: '1fp' }) {
          ForEach(this.websiteList, (item: Website) => {
            ListItem() {
              Column() {
                Text(item.name).fontWeight(FontWeight.Bold).fontColor(Color.Black)
                Text(item.link).fontColor(Color.Gray).margin({top:'5fp'})
              }.alignItems(HorizontalAlign.Start)
            }.padding('15fp')
            .clickEffect({level: ClickEffectLevel.LIGHT})
            .onClick(event => {
                this.pageStack?.pushDestinationByName("WebPage", item, true)
            })
          })
        }.divider({ color: '#efefef', strokeWidth: 1 })
        .width('100%')
        .height('100%')
      }
      .height('100%')
      .width('100%')
    }.title("常用网站列表")
    .onReady((context: NavDestinationContext) => {
      console.log("===============onReady================")
      this.pageStack = context.pathStack
      this.queryData()
    })
  }

  queryData() {
    let httpRequest = http.createHttp()
    httpRequest.request("https://www.wanandroid.com/friend/json",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        // expectDataType: http.HttpDataType.OBJECT
      },
      //回调
      (err: BusinessError, data: http.HttpResponse) => {
        if (!err) {
          console.log("result====>" + data.result)
          let res: WebsiteRes = JSON.parse(data.result.toString()) as WebsiteRes
          if (res.errorCode == 0) {
            this.websiteList = res.data as Array<Website>
          } else {
            promptAction.showToast(
              {
                message: res.errorMsg,
                duration: 3000
              }
            )
          }
        } else {
          promptAction.showToast(
            {
              message: err.message,
              duration: 3000
            }
          )
          httpRequest.destroy()
        }
      }
    )
  }
}

class WebsiteRes {
  data?: Array<Website>
  errorCode?: number
  errorMsg?: string
}
