@Builder
export function PageBuilder() {
  CheckPage();
}


@Entry
@Component
struct CheckPage {
  build() {
    NavDestination() {
      Column({ space: 15 }) {
        Text('多选')
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

        CheckboxGroup({ group: 'group1' })
        Text('全选')
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

        Text('单选')
        Radio({value: 'e', group: 'radioGroup'})
          .onChange(isChecked => {
            console.log("isChecked e " + isChecked)
          })
        Radio({value: 'f', group: 'radioGroup'})
          .onChange(isChecked => {
            console.log("isChecked f " + isChecked)
          })
        Radio({value: 'g', group: 'radioGroup'})
          .onChange(isChecked => {
            console.log("isChecked g " + isChecked)
          })
      }
    }
    .title('选择组件')
  }
}