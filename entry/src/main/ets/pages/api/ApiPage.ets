import { scanBarcode, scanCore } from "@kit.ScanKit";
import { camera, cameraPicker as picker } from '@kit.CameraKit';
import { photoAccessHelper } from "@kit.MediaLibraryKit";

@Builder
export function PageBuilder() {
  ApiPage();
}

@Entry
@Component
struct ApiPage {

  build() {
    NavDestination() {
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
      }
    }
    .height('100%')
    .width('100%')
    .title('系统Api调用')
  }
}