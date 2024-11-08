import { CommonConstants } from "../common/constants/CommonConstants"
import { HighLightText, SentencePair } from "../model/DictModel"
import { media } from "@kit.MediaKit"

@Component
export struct SentenceCell {

  item: SentencePair = new SentencePair()

  build() {
    Column() {
      Row() {
        Button({type: ButtonType.Capsule, buttonStyle: ButtonStyleMode.TEXTUAL}) {
          Image($r('app.media.ic_voice_3'))
            .width('20vp')
            .height('20vp')
        }
        .width('32vp')
        .margin({right: CommonConstants.COMMON_SPACING})

        Column({ space: CommonConstants.COMMON_MIN_SPACING }) {
          Text() {
            ForEach(this.item.parseAndHighlightText(), (htl: HighLightText) => {
              Span(htl.str + " ")
                .fontColor(htl.isHighLight ? Color.Red : Color.Black)
                .fontSize(18)
                .onClick((event) => {
                  console.log("test-> 点击:", htl.str)
                })
                .layoutWeight(1)
            })
          }
          .constraintSize({
            maxWidth: '100%'
          })

          Text(this.item.sentenceTranslation)
            .flexShrink(1)
        }
        .width(CommonConstants.FULL_WIDTH)
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Row(){
        Text(this.item.source)
        Row({space: CommonConstants.COMMON_MIN_SPACING}) {
          Button("跟读", {type: ButtonType.Normal})
            .fontSize(14)
            .onClick(() => {

            })
            .backgroundColor(Color.Gray)
            .borderRadius(10)
            .height(30)

          Button("收藏", {type: ButtonType.Normal})
            .fontSize(14)
            .onClick(() => {

            })
            .backgroundColor( Color.Gray)
            .borderRadius(10)
            .height(30)
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }
}