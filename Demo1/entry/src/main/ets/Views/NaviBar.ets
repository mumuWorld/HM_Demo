import { router } from "@kit.ArkUI"
import { PageRouterParam } from "../model/RouterModel"


@Component
export struct NaviBar {

  @State backTitle: string = ""

  constructor(backTitle: string) {
    super()
    this.backTitle = backTitle
    console.log("test-> 参数:", backTitle)
  }

  aboutToAppear(): void {
    let p: PageRouterParam = router.getParams() as PageRouterParam
    console.log("test-> NaviBar appear 收到参数2" + p.source)
  }

  build() {
    Column() {
      Row() {
        Button(){
          Row() {
            Image($r("app.media.common_back_black"))
              .width(24)
            Text(this.backTitle)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .padding({
                left: $r('app.float.common_spacing'),
              })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)
          // .backgroundColor(Color.Brown)
        }.onClick(() => {
          router.back()
        })
        .backgroundColor(Color.Transparent)
        .padding({
          left: $r('app.float.common_spacing'),
        })
      }
      .height(44)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.End)
    .alignItems(HorizontalAlign.Start)
  }
}