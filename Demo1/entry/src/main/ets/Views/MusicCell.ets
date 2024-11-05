import { SentsDatum } from "../model/DictModel";


@Component
export struct MusicCell {

  @State sentence: SentsDatum = new SentsDatum()

  constructor(item: SentsDatum) {
    super()
    this.sentence = item
  }

  build() {
    Column() {
      Row() {
        Image("")
          .height(50)
          .borderRadius(25)
        Column() {
          Text(this.sentence.lyric)
            .maxLines(2)
            .margin({bottom:16})
          Text(this.sentence.lyricTranslation)
        }
      }

      Row(){
        Text("去网易云听|"+this.sentence.songName + " - " + this.sentence.singer + " >")
        Button(){
          Text(this.sentence.supportCount?.toString())
        }
      }
    }
  }
}