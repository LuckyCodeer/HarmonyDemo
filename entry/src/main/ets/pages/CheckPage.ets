@Builder
export function PageBuilder() {
  CheckPage();
}


@Entry
@Component
struct CheckPage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 15 }) {
          Text('多选').fontColor(Color.Blue)
          Row({ space: 20 }) {
            Row() {
              Checkbox({ name: 'a' })
              Text('苹果')
            }

            Row() {
              Checkbox({ name: 'b' })
              Text('香蕉')
            }

            Row() {
              Checkbox({ name: 'c' })
              Text('葡萄')
            }

            Row() {
              Checkbox({ name: 'd' })
              Text('西瓜')
            }
          }

          Row() {
            Text('全选').fontColor(Color.Blue)
            CheckboxGroup({ group: 'group1' })
          }.margin({top: 20})
          Row({ space: 20 }) {
            Row() {
              Checkbox({ name: 'a', group: 'group1' })
              Text('苹果')
            }

            Row() {
              Checkbox({ name: 'b', group: 'group1' })
              Text('香蕉')
            }

            Row() {
              Checkbox({ name: 'c', group: 'group1' })
              Text('葡萄')
            }

            Row() {
              Checkbox({ name: 'd', group: 'group1' })
              Text('西瓜')
            }
          }

          Text('单选').margin({top: 20}).fontColor(Color.Blue)
          Row({ space: 20 }) {
            Row() {
              Radio({ value: 'e', group: 'radioGroup' })
                .onChange(isChecked => {
                  console.log("isChecked e " + isChecked)
                })
              Text('红色')
            }
            Row() {
              Radio({ value: 'f', group: 'radioGroup' })
                .onChange(isChecked => {
                  console.log("isChecked f " + isChecked)
                })
              Text('绿色')
            }
            Row() {
              Radio({ value: 'g', group: 'radioGroup' })
                .onChange(isChecked => {
                  console.log("isChecked g " + isChecked)
                })
              Text('白色')
            }
            Row() {
              Radio({ value: 'h', group: 'radioGroup' })
                .onChange(isChecked => {
                  console.log("isChecked g " + isChecked)
                })
              Text('粉色')
            }
          }

          Text('下拉选择').margin({top: 20}).fontColor(Color.Blue)
          Select([{
            value: '北京',
          }, {
            value: '上海',
          }, {
            value: '广州',
          }, {
            value: '深圳',
          }
          ]).value('北京')
            .onSelect((index, value) => {
              this.getUIContext().getPromptAction().showToast({
                message: '选择了' + value
              })
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(20)
      }
    }
    .title('选择组件')
  }
}