import { ResultPage } from '../model/ResultPage';
import { router, window } from '@kit.ArkUI';
import util from '@ohos.util';
import { DictResponse } from '../model/DictModel';
import { PageRouterParam, PageRouterParamMdoel } from '../model/RouterModel'
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import Logger from '../common/Logger';
import { NaviBar } from '../views/NaviBar';
// import 'basic/src/main/ets/pages/Index' // 引入共享包library中的命名路由页面

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State word: string = '';
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  @StorageLink('topArea') topArea: number = 0;
  dict?: DictResponse

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      let area = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.topArea = px2vp(area.topRect.height);
      let bottom = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      // this.bottomArea = px2vp(bottom.bottomRect.height);
      //
      // console.log("test-> 安全区域高度: ", this.topArea, "底部：", this.bottomArea)
      if (this.topArea > 0) {
        windowStage.setWindowLayoutFullScreen(true);
      }
    });
  }

  aboutToDisappear(): void {
  }

  build() {
    Column({ space: 10 }) {
      NaviBar({ backTitle: "首页", showBack: false })
        .height(44)
        .margin({ top: this.topArea })

      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .align(Alignment.Center)
        .backgroundColor(Color.White)
      TextInput({ placeholder: "输入查询单词", text: this.word })
        .onSubmit((type) => {
          if (this.word.length < 1) {
            return
          }
          let param: PageRouterParam = {
            source: "首页"
          }
          this.pageStack.pushPath({ name: "ResultPage", param: param })
        })

      Button('结果页')
        .onClick(() => {
          console.log('test-> router')
          let param: PageRouterParam = {
            source: "首页"
          }
          router.pushUrl({ url: "model/ResultPage", params: param })
        })
        .backgroundColor(Color.Black)

      Button('HAP跳转')
        .onClick(() => {
          let ctx = getContext(this) as common.UIAbilityContext
          ctx.startAbilityForResult({
            bundleName: "com.example.mmappdemo",
            abilityName: "FeatureToolAbility",
            action: "OCR",
            parameters: { "key1": "value1" }
          }).then((reslut) => {
            console.log("test-> 收到ability 回调: ", reslut.want?.action, reslut.want?.parameters?.["info"])
          }).catch((error: BusinessError) => {
            Logger.error("index", 'test->start audio ability failed, error: ' + JSON.stringify(error))
          })
        })

      Button('HAR包: 绝对路径跳转')
        .onClick(() => {
          console.log('test-> router')
          let param: PageRouterParam = {
            source: "首页"
          }
          router.pushUrl({ url: "@bundle:com.example.mmappdemo/basic/ets/pages/Index", params: param })
        })
      Button('HAR包: 页面别名跳转')
        .onClick(() => {
          console.log('test-> router')
          let param: PageRouterParam = {
            source: "首页"
          }
          router.pushNamedRoute({name:"BasicIndexPage",params: param})
        })
      Button('测试json')
        .onClick(() => {
          this.testJson()
        })
    }
    .height('100%')
    .width('100%')
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
        console.log('test->读取成功1:', value)
        let str = util.TextDecoder.create('utf-8', { ignoreBOM: true }).decodeToString(rawFile, { stream: false })
        console.log('test->读取成功2:', str)
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
      let str = util.TextDecoder.create('utf-8', { ignoreBOM: true }).decodeToString(data, { stream: false })
      try {
        console.log('test->解析:1', str)
        this.dict = JSON.parse(str)
        console.log('test->解析: ', this.dict?.simple?.query)
      } catch (e) {
        console.log("test-> err", e)
      }
    })

    let jStr =
      "{\"simple\":{\"query\":\"good\",\"word\":[{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\",\"collegeExamVoice\":{\"speechWord\":\"good\"}}]}}"
    this.dict = JSON.parse(jStr)
    // console.log("test->1111",this.dict?.simple?.query)
  }
}
