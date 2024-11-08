import { router } from "@kit.ArkUI"
import { PageRouterParam, PageRouterParamMdoel } from "../model/RouterModel"


@Component
export struct NaviBar {

  @State backTitle: string = ""

  showBack: boolean = false

  aboutToAppear(): void {
    let p: PageRouterParam = new PageRouterParamMdoel(router.getParams() as PageRouterParam)
    console.log("test-> NaviBar appear 收到参数2" + p.source)
  }

  build() {
    Stack() {
      Column() {
        if (this.showBack) {
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
      }
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.Start)
    }
    .alignContent(Alignment.TopStart)
  }
}