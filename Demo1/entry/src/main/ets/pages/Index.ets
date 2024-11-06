import { ResultPage } from './ResultPage';
import { router } from '@kit.ArkUI';
import util from '@ohos.util';
import { DictResponse } from '../model/DictModel';
import { PageRouterParam } from  '../model/RouterModel'
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

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
    let path = getContext().cacheDir
    console.log('test->     json,:', path)
    let _ctx = getContext(this)
    console.log('test->     _ctx,:', _ctx)


    // 次级文件夹可直接使用 json/good.json
    getContext().resourceManager.getRawFileContent("rawfile/test.text", (error: BusinessError, value: Uint8Array) => {
      if (error != null) {
        console.error("test->getRawFileContent promise error is: " + error.name, "msg:", error.message, ",data:",
          error.data, ",code:", error.code);
      } else {
        let rawFile = value;
        console.log('test->读取成功1:',value)
        let str = util.TextDecoder.create('utf-8', {ignoreBOM: true}).decodeToString(rawFile, {stream: false})
        console.log('test->读取成功2:',str)
      }
    });



    let ctx = getContext()

    console.log('test->   读取list ------------ ctx：', ctx)
    try { // 传入""表示获取rawfile根目录下的文件列表
      getContext(this).resourceManager.getRawFileList("", (error: BusinessError, value: Array<string>) => {
        if (error != null) {
          console.error(`test->callback getRawFileList failed, error code: ${error.code}, message: ${error.message}.`);
        } else {
          let rawFile = value;
          console.log("test-> 读取list成功：", value)
        }
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`callback getRawFileList failed, error code: ${code}, message: ${message}.`);
    }
    console.log('test->   读取 ------------ json')

    // let context = getContext() as common.UIAbilityContext;
    getContext(this).resourceManager.getRawFileContent("test.text", (error, data) => {
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
    // console.log("test->1111",this.dict?.simple?.query)
  }

  build() {
    Column({space: 10}) {
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
