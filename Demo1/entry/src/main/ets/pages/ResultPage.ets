import { fileUri } from '@kit.CoreFileKit';
import { resourceManager } from "@kit.LocalizationKit";
import { router } from "@kit.ArkUI";
import { DictResponse, SimpleWord } from "../model/DictModel";
import { PhoneButton } from '../Views/PhoneButton';
import { sim } from '@kit.TelephonyKit';


@Entry
@Component
export struct ResultPage {

  @State dict: DictResponse = new DictResponse()
  @State sw: SimpleWord = new SimpleWord()

  getWordData() {
    // str = this.context.get
    // JSON.has()
    // let ctx = getContext(this) as common.UIAbilityContext;
    // let resourceManager = ctx.resourceManager
    let jStr = "{\"simple\":{\"query\":\"good\",\"word\":[{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\",\"collegeExamVoice\":{\"speechWord\":\"good\"}}]}}"
    this.dict = JSON.parse(jStr)
    console.log("test->1111",this.dict?.simple?.query)
  }

  aboutToAppear(): void {
    let p = router.getParams()
    console.log("test-> appear 收到参数2" + p.toString())
    this.getWordData()

  }

  pathStack: NavPathStack = new NavPathStack()

  baseSpacing: number = 16

  build() {
    Stack() {

      Column() {
        Text(this.dict.simple?.query)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
        Blank()
          .color(Color.Black)
          .height(1)
      }.width('100%').height('100%')
      .padding({left: this.baseSpacing, right: this.baseSpacing, top: 56 + 24})
      .alignItems(HorizontalAlign.Start)


      this.dict.simple?.word?.forEach((word) => {
        Row(){ PhoneButton(word)}
      })
      // Row(){
      //   PhoneButton(this.dict.simple?.word?[0])
      // }
      // .alignItems(VerticalAlign.Top)

    }
    .alignContent(Alignment.TopStart)
      .backgroundColor(Color.Green)

  }

  onPageShow(): void {
    console.log('test->' + this.dict.simple?.query + '测试参数')
  }
}
