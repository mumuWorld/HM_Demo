import { ResultPage } from './ResultPage';
import { router } from '@kit.ArkUI';
import util from '@ohos.util';
import { DictResponse } from '../model/DictModel';
import { PageRouterParam } from  '../model/RouterModel'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State word: string = '';
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  dict?: DictResponse

  @Builder
  PagesMap(name: string, param: PageRouterParam) {
    if (name == 'ResultPage') {
      ResultPage()
    }
  }
  aboutToAppear(): void {
  }

  aboutToDisappear(): void {
  }

  testJson() {
    console.log('test->     json')
    // let context = getContext() as common.UIAbilityContext;

    getContext(this).resourceManager.getRawFileContent("/good.json", (error, data) => {
      if (!error) {
        console.log('test-> 读取失败', error)
        return
      }
      if (data == undefined) {
        console.log('test-> 读取失败222', error)
        return
      }

      console.log('test->解析:0:', data)
      let str = util.TextDecoder.create('utf-8', {ignoreBOM: true}).decodeToString(data, {stream: false})
      try {
        console.log('test->解析:1', str)
        this.dict = JSON.parse(str)
        console.log('test->解析: ', this.dict?.simple?.query)
      } catch (e) {
        console.log("test-> err",e)
      }
    })

    let jStr = "{\"simple\":{\"query\":\"good\",\"word\":[{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\",\"collegeExamVoice\":{\"speechWord\":\"good\"}}]}}"
    this.dict = JSON.parse(jStr)
    console.log("test->1111",this.dict?.simple?.query)
  }

  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      // Navigation(this.pageStack) {
        TextInput({ placeholder: "输入查询单词", text: this.word })
          .onSubmit((type) => {
            if (this.word.length < 1) {
              return
            }
            let param = new PageRouterParam()
            this.pageStack.pushPath({ name: "ResultPage", param: param })
          })
        Button('跳转')
          .onClick(()=>{
            let param = new PageRouterParam()
            this.pageStack.pushPath({ name: "ResultPage", param: param })
          })
        Button('router')
          .onClick(() => {
            console.log('test-> router')
            let param = new PageRouterParam()
            param.source = "首页"
            router.pushUrl({url: "pages/ResultPage", params: param})
          })
          Button('测试json')
            .onClick(() => {
                this.testJson()
              // router.pushUrl({url: "pages/TestPage"},router.RouterMode.Standard, (error) => {
              //   console.log('test-> error: ', error)
              // })
            })
      // }
      // .mode(NavigationMode.Stack)
      // .navDestination(this.PagesMap)


    }
    .height('100%')
    .width('100%')
  }
}
