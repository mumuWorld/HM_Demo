import { router } from '@kit.ArkUI';

@Entry({ routeName: 'BasicIndexPage' })
@Component
struct Index {
  @State message: string = 'Basic Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button("路由返回")
          .onClick(() => {
            router.back()
            console.log("test->返回成功")
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}