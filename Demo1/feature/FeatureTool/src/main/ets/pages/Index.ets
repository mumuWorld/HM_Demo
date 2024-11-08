import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button("返回上一个Ability")
        .onClick(() => {
          let ctx = getContext(this) as common.UIAbilityContext
          // context为被调用方UIAbility的AbilityContext
          ctx.terminateSelfWithResult({
            resultCode: 10000,
            want: {
              bundleName: 'com.example.mmappdemo',
              abilityName: 'EntryAbility.ets',
              // moduleName: 'module1',
              action:"test  Action",
              parameters: {
                info: '来自FuncAbility Index页面',
              },
            },
          }, (err) => {
          });
          console.log("test->返回成功")
        })
    }
    .height('100%')
    .width('100%')
  }
}