import { HighLightText, SentencePair } from "../model/DictModel"

@Component
export struct SentenceCell {

  @State item: SentencePair = new SentencePair()

  constructor(sentence: SentencePair) {
    super()
    this.item = sentence
  }

  build() {
    Column() {
      Text() {
        ForEach(this.item.parseAndHighlightText(), (htl: HighLightText) => {
          Span(htl.str + " ")
            .fontColor(htl.isHighLight ? Color.Red : Color.Black)
            .fontSize(18)
            .onClick((event) => {
              console.log("test-> 点击:", htl.str)
            })
        })
      }
      Text(this.item.sentenceTranslation)
      Row(){
        Text(this.item.source)
        Row() {
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
    }
    .alignItems(HorizontalAlign.Start)
  }
}