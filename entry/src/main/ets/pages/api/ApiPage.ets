import { scanBarcode, scanCore } from "@kit.ScanKit";
import { camera, cameraPicker as picker } from '@kit.CameraKit';
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import  { picker as filePicker } from '@kit.CoreFileKit';
import { BusinessError } from "@kit.BasicServicesKit";
import { abilityAccessCtrl, common, PermissionRequestResult, Permissions } from "@kit.AbilityKit";
import { geoLocationManager } from "@kit.LocationKit";
import { promptAction } from "@kit.ArkUI";

@Builder
export function PageBuilder() {
  ApiPage();
}

@Entry
@Component
struct ApiPage {
  private location?: geoLocationManager.Location

  build() {
    NavDestination() {
      Scroll() {
        Column({space: 20}) {
          Button('扫一扫')
            .onClick(() => {
              // 定义扫码参数options
              let options: scanBarcode.ScanOptions = {
                scanTypes: [scanCore.ScanType.ALL],
                enableMultiMode: true,
                enableAlbum: true
              };
              scanBarcode.startScanForResult(this.getUIContext().getHostContext(), options)
                .then((result: scanBarcode.ScanResult) => {
                  this.getUIContext().getPromptAction().showToast({
                    message: result.originalValue,
                    duration: 5000
                  })
                })
            })

          Button('相册选择')
            .onClick(async () => {
              let photoPicker = new photoAccessHelper.PhotoViewPicker();
              let options: photoAccessHelper.PhotoSelectOptions = {
                isEditSupported: false,
                maxSelectNumber: 5,
                isSearchSupported: false
              }
              let pickerResult = await photoPicker.select(options)
              if (pickerResult.photoUris != null && pickerResult.photoUris.length > 0) {
                this.getUIContext().getPromptAction().showToast({
                  message: pickerResult.photoUris.toString()
                })
              }
              console.log("pickerResult======> " + pickerResult.photoUris)
            })

          Button('调起相机')
            .onClick(async () => {
              let pickerProfile: picker.PickerProfile = {
                cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK, //摄像头位置，前或者后
                videoDuration: 10 //视频最大时长
              };
              let pickerResult: picker.PickerResult = await picker.pick(this.getUIContext().getHostContext(),
                [picker.PickerMediaType.PHOTO, picker.PickerMediaType.VIDEO], pickerProfile)

              if (pickerResult.resultCode == 0) {
                this.getUIContext().getPromptAction().showToast({
                  message: pickerResult.resultUri
                })
              } else {
                this.getUIContext().getPromptAction().showToast({
                  message: '取消操作'
                })
              }
              console.log("pickerResult======> " + pickerResult.resultUri + "  " + pickerResult.resultCode)
            })

          Button('文件选择')
            .onClick(() => {
              try {
                let documentSelectOptions = new filePicker.DocumentSelectOptions();
                documentSelectOptions.maxSelectNumber = 1 //最大选择数
                // documentSelectOptions.fileSuffixFilters = ["表格|.xls"] //选择指定类型的文件
                let documentPicker = new filePicker.DocumentViewPicker(getContext());
                documentPicker.select(documentSelectOptions).then((documentSelectResult: Array<string>) => {
                  if (documentSelectResult.length > 0) {
                    this.getUIContext().getPromptAction().showToast({
                      message: JSON.stringify(documentSelectResult)
                    })
                  }
                }).catch((err: BusinessError) => {
                  console.error(`DocumentViewPicker.select failed with err, code is: ${err.code}, message is: ${err.message}`);
                });
              } catch (error) {
                let err: BusinessError = error as BusinessError;
                console.error(`DocumentViewPicker failed with err, code is: ${err.code}, message is: ${err.message}`);
              }
            })

          Button('获取定位')
            .onClick(() => {
              //先请求权限
              let permissions: Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION'];
              let context = getContext(this) as common.UIAbilityContext
              let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager()
              atManager.requestPermissionsFromUser(context, permissions).then((data: PermissionRequestResult) => {
                let grantStatus: Array<number> = data.authResults;
                let length: number = grantStatus.length;
                let isGrantPermission = false
                for (let i = 0; i < length; i++) {
                  if (grantStatus[i] === 0) {
                    //权限已授权
                    isGrantPermission = true
                  } else {
                    this.getUIContext().getPromptAction().showToast({ message: '请授权相关权限，否则该功能无法使用' });
                    return;
                  }
                }
                if (isGrantPermission) {
                  geoLocationManager.getCurrentLocation().then((location: geoLocationManager.Location) => {
                    this.location = location
                    console.log("additions===> " + location.additions?.toString())
                    promptAction.showToast({
                      message: "经度：" + location.longitude + "，纬度：" + location.latitude,
                      duration: 5000
                    })
                  })
                }
              })
            })

          Button('逆地理编码')
            .onClick(() => {
              if (this.location == null) {
                promptAction.showToast({message: '请先点击获取定位'})
                return
              }
              let request: geoLocationManager.ReverseGeoCodeRequest = {
                latitude: this.location?.latitude!!,
                longitude: this.location?.longitude!!
              }
              geoLocationManager.getAddressesFromLocation(request, (err, data) => {
                if (data) {
                  data.forEach((item, position) => {
                    console.log("address: " + item.placeName)
                  })
                  promptAction.showToast({message: data[0].placeName})
                }
              })
            })
        }
      }
    }
    .height('100%')
    .width('100%')
    .title('系统Api调用')
  }
}