import { CommonConstants } from "../common/constants/CommonConstants"
import { SimpleWord } from "../model/DictModel"

@Component
export struct PhoneButton {

  sw?: SimpleWord = new SimpleWord()

  build() {
      Row({space: CommonConstants.COMMON_SPACING}) {
        if (this.sw?.ukphone) {
          Row() {
            Button({type: ButtonType.Capsule, buttonStyle: ButtonStyleMode.TEXTUAL}) {
              Image($r('app.media.ic_voice_3'))
                .width('20vp')
                .height('20vp')
            }
            .width('32vp')
            .height('32vp')

            Text(`英/${this.sw?.ukphone}/`)
          }
          .alignItems(VerticalAlign.Center)
          .padding({right: CommonConstants.COMMON_SPACING})
          .backgroundColor(Color.Gray)
          .borderRadius(16)
        }

        if (this.sw?.usphone) {
          Row() {
            Button({type: ButtonType.Capsule, buttonStyle: ButtonStyleMode.TEXTUAL}) {
              Image($r('app.media.ic_voice_3'))
                .width('20vp')
                .height('20vp')
            }
            .width('32vp')
            .height('32vp')

            Text(`美/${this.sw?.usphone}/`)
          }
          .padding({right: CommonConstants.COMMON_SPACING})
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)
          .backgroundColor(Color.Gray)
          .borderRadius(16)
        }
      }
  }
}


