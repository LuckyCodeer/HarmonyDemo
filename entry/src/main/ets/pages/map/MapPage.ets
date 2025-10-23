import { MapComponent } from "@hms.core.map.MapComponent";
import { map, mapCommon } from "@kit.MapKit";
import { geoLocationManager } from "@kit.LocationKit";
import { abilityAccessCtrl, common, PermissionRequestResult, Permissions } from "@kit.AbilityKit";

@Builder
export function PageBuilder() {
  MapPage();
}

/**
 * 地图
 */
@Entry
@Component
struct MapPage {
  private location?: geoLocationManager.Location
  private mapController?: map.MapComponentController;
  private mapOptions: mapCommon.MapOptions = {
    position: {
      target: {
        latitude: this.location != null ? this.location?.latitude : 0,
        longitude: this.location != null ? this.location?.longitude : 0
      }, // 中心点坐标
      zoom: 10 // 缩放级别
    }
  }

  aboutToAppear(): void {
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
        })
      }
    })
  }

  build() {
    NavDestination() {
      Column() {
        MapComponent({mapOptions: this.mapOptions, mapCallback: (err, mapController) => {
          console.log("err===> " + JSON.stringify(err))
          this.mapController = mapController

          let markerOptions: mapCommon.MarkerOptions = {
            position: {
              latitude: this.location != null ? this.location?.latitude : 0,
              longitude: this.location != null ? this.location?.longitude : 0
            },
            clickable: true,
            // 设置信息窗标题
            title: "自定义信息窗"
          };
          this.mapController?.addMarker(markerOptions);
        }}).width("100%").height("100%")
      }
    }
    .height('100%')
    .width('100%')
    .title('地图')
  }
}