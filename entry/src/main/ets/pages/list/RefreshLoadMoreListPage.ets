import { PullToRefresh, PullToRefreshType } from '@ohos/pulltorefresh';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { ArticleItem } from '../../entity/ArticleItem';
import { Website } from '../../entity/Website';

@Builder
export function PageBuilder() {
  RefreshLoadMoreListPage()
}

//动态添加list组件的属性
class MyListModifier implements AttributeModifier<ListAttribute> {
  applyNormalAttribute(instance: ListAttribute): void {
    instance.divider({ strokeWidth: 1, color: '#efefef' });
  }
}

/**
 * 使用三方库实现下拉刷新上拉加载更多
 * ohpm install @ohos/pulltorefresh
 * https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Fpulltorefresh
 */
@Entry
@Component
struct RefreshLoadMoreListPage {
  @State articleItemList: Array<ArticleItem> = new Array<ArticleItem>()
  @State refreshing: boolean = false;
  private modifier: MyListModifier = new MyListModifier();
  private pageNum = 0 //页码
  pageStack?: NavPathStack

  build() {
    NavDestination() {
      Column() {
        PullToRefresh({
          //必传项，容器主体布局类型
          pullToRefreshType: PullToRefreshType.LIST,
          //必传项，控制是否进行下拉刷新
          refreshing: $refreshing,
          // 必传项，需绑定传入主体布局内的列表或宫格组件
          customList: () => {
            // 一个用@Builder修饰过的UI方法
            this.getListView();
          },
          //可选项，属性方法修改时触发
          modifierListAttribute: this.modifier,
          // 可选项，下拉刷新回调
          onRefresh: () => {
            return new Promise<string>((resolve, reject) => {
              this.pageNum = 0
              this.queryData(resolve)
            });
          },
          // 可选项，上拉加载更多回调
          onLoadMore: () => {
            return new Promise<string>((resolve, reject) => {
              this.pageNum++
              this.queryData(resolve)
            });
          },
          //可选项，自定义下拉刷新动画布局
          customRefresh: null,
          //可选项，自定义上拉加载动画布局
          customLoad: null,
        })
      }
    }
    .title('下拉刷新上拉加载更多')
    .height('100%')
    .width('100%')
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack
      this.queryData(undefined)
    })
  }

  queryData(resolve?: (value: string | PromiseLike<string>) => void) {
    let httpRequest = http.createHttp()
    httpRequest.request("https://www.wanandroid.com/article/list/" + this.pageNum + "/json",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        // expectDataType: http.HttpDataType.OBJECT
      },
      //回调
      (err: BusinessError, data: http.HttpResponse) => {
        if (resolve != null) {
          resolve(this.pageNum == 0 ? '刷新成功' : '')
        }
        if (!err) {
          console.log("result====>" + data.result)
          let res: Article = JSON.parse(data.result.toString()) as Article
          if (res.errorCode == 0) {
            let dataList = res.data?.datas as Array<ArticleItem>
            if (this.pageNum == 0) {
              this.articleItemList = dataList
            } else {
              this.articleItemList.push(...dataList)
            }
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

  @Builder
  private getListView() {
    ForEach(this.articleItemList, (item: ArticleItem) => {
      ListItem() {
        Column({ space: '2fp' }) {
          Text(item.title)
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text(item.link)
            .width('100%')
            .fontSize(15)
          Text(item.shareUser)
            .width('100%')
            .fontSize(15)
          Text(item.publishTime?.toString())
            .width('100%')
            .fontSize(15)
        }
      }.padding('15fp')
      .backgroundColor(Color.White)
      .clickEffect({ level: ClickEffectLevel.LIGHT })
      .onClick(()=> {
        let website = new Website()
        website.name = item.title
        website.link = item.link
        this.pageStack?.pushDestinationByName("WebPage", website, true)
      })
    })
  }
}

class Article {
  data?: ArticleData
  errorCode?: number
  errorMsg?: string
}

class ArticleData {
  curPage?: number
  total?: number
  datas?: Array<ArticleItem>
}