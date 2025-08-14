import { promptAction } from "@kit.ArkUI"
import window from '@ohos.window';
import { DateUtils } from "../utils/DateUtils";

@Builder
export function PageBuilder() {
  DialogPage()
}

@CustomDialog
@Component
struct LoadingDialogExample {
  controller?: CustomDialogController;
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      LoadingProgress().color(Color.Blue).layoutWeight(1)
    }.borderRadius(10).width(100).height(100)
  }
}

@Entry
@Component
struct DialogPage {
  dialogController: CustomDialogController | null = null;
  @State showPop: boolean = false

  build() {
    NavDestination() {
      Column({ space: '20fp' }) {
        Button('对话框').onClick(() => {
          promptAction.showDialog({
            title: "提示",
            message: "确定要删除该数据吗？",
            buttons: [
              {
                text: '取消',
                color: '#666666',
              },
              {
                text: '确定',
                color: '#000000'
              }
            ],
            isModal: true
          }, (err, data) => {
            switch (data.index) {
              case 0:
                promptAction.showToast({ message: '点击了取消' })
                break
              case 1:
                promptAction.showToast({ message: '点击了确定' })
                break
            }
          })
        })

        Button('操作弹框').onClick(() => {
          promptAction.showActionMenu({
            title: '请选择',
            buttons: [
              {
                text: '红色',
                color: "#000000"
              },
              {
                text: '绿色',
                color: "#000000"
              },
              {
                text: '黑色',
                color: "#000000"
              },
              {
                text: '白色',
                color: "#000000"
              }
            ]
          }, (err, data) => {
            promptAction.showToast({ message: data.index.toString() })
          })
        })

        Button('Loading弹框').onClick(() => {
          //获取窗口对象
          let windowClass = window.getLastWindow(this.getUIContext().getHostContext());
          windowClass.then(window => {
            //获取窗口信息，设置maskRect
            /*let properties = window.getWindowProperties();
            let maskRect = {
              x: this.getUIContext().px2vp(properties.windowRect.left + 150),
              y: this.getUIContext().px2vp(properties.windowRect.top + 350),
              width: this.getUIContext().px2vp(properties.windowRect.width - 300),
              height: this.getUIContext().px2vp(properties.windowRect.height - 700)
            } as Rectangle*/
            if (this.dialogController == null) {
              this.dialogController = new CustomDialogController({
                builder: LoadingDialogExample({
                  cancel: () => {
                  },
                  confirm: () => {
                  },
                }),
                // cancel: this.exitApp,
                isModal: true,
                // maskRect: maskRect,
                autoCancel: false,
                // maskColor: "#33AA0000",
                showInSubWindow: false,
                backgroundBlurStyle: BlurStyle.NONE,
                onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
                  if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
                    dismissDialogAction.dismiss();
                  }
                  if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
                    dismissDialogAction.dismiss();
                  }
                },
                alignment: DialogAlignment.Center,
                customStyle: false,
                cornerRadius: 10,
                openAnimation: { duration: 0, tempo: 0 },
                closeAnimation: { duration: 0, tempo: 0 }
              })
            }
            this.dialogController.close();
            this.dialogController.open();
          })
        })

        Button('提示弹框').onClick(() => {
          this.getUIContext().showAlertDialog({
            title: '提示',
            message: '请求错误，请重试！',
            autoCancel: false,
            confirm: {value: '确定', action: ()=> {

            }}
          })
        })

        Button('日期日历选择').onClick(() => {
          CalendarPickerDialog.show({
            onAccept: (date) => {
              let dateUtils = new DateUtils()
              promptAction.showToast({ message: dateUtils.dateFormat(date) })
            }
          })
        })

        Button('日期滑动选择').onClick(() => {
          this.getUIContext().showDatePickerDialog({
            lunarSwitch: true,
            showTime: false,
            onDateAccept: (date) => {
              let dateUtils = new DateUtils()
              promptAction.showToast({ message: dateUtils.dateFormat(date) })
            }
          })
        })

        Button('气泡')
          .bindPopup(this.showPop, {
            message: '这是一个按钮',
            arrowPointPosition: ArrowPointPosition.CENTER,
            placement: Placement.Top,
            onStateChange: (b) => {
              this.showPop = b.isVisible
            }
          })
          .onClick(() => this.showPop = !this.showPop)
      }
    }.title("弹框")
  }
}