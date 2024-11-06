import { SimpleWord } from "../model/DictModel"

@Component
export struct PhoneButton {

  sw?: SimpleWord = new SimpleWord()

  build() {
      Row() {
        if (this.sw?.ukphone) {
          Text(`英/${this.sw?.ukphone}/`)
            .backgroundColor(Color.Gray)
            .borderRadius(4)
            .height(20)
        }

        if (this.sw?.usphone) {
          Text(`美/${this.sw?.usphone}/`)
            .backgroundColor(Color.Gray)
            .borderRadius(4)
            .height(20)
            .margin({left: 20})
        }
      }
  }
}


