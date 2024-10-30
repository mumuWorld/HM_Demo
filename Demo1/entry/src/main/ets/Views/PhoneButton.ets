import { Simple, SimpleWord } from "../model/DictModel"

@Component
export struct PhoneButton {

  @State sw: SimpleWord = new SimpleWord()

  constructor(sw?: SimpleWord) {
    super()
    this.sw = sw ?? new SimpleWord()
  }

  build() {
      Row() {
        Text(`英/${this.sw?.ukphone}/`)
          .backgroundColor(Color.Gray)
          .borderRadius(4)
          .height(20)

        Text(`美/${this.sw?.usphone}/`)
          .backgroundColor(Color.Gray)
          .borderRadius(4)
          .height(20)
          .margin({left: 20})
      }
  }
}


