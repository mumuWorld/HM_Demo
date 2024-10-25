import { JSON } from "@kit.ArkTS";
import { fileUri } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { resourceManager } from "@kit.LocalizationKit";

@Builder
export function ResultPageBuilder(name: string, param: ResultPageParam) {
  ResultPage({param: param})
}

export class ResultPageParam {
  word: string = "test"
  source: string = ""

  constructor() {
  }
}

@Entry
@Component
export struct ResultPage {

  @State param: ResultPageParam = new ResultPageParam();

  constructor(param: ResultPageParam) {
    super();
    this.param = param
  }

  getWordData() {
    // str = this.context.get
    // JSON.has()
    let ctx = getContext(this) as common.UIAbilityContext;
    let resourceManager = ctx.resourceManager

  }

  aboutToAppear(): void {

  }

  pathStack: NavPathStack = new NavPathStack()

  baseSpacing: number = 16

  build() {
    NavDestination() {
      Column() {
        Text(this.param.word)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
        Blank()
          .color(Color.Black)
          .height(1)


      }.width('100%').height('100%')
      .padding({left: this.baseSpacing, right: this.baseSpacing})
      .alignItems(HorizontalAlign.Start)

    }.title("返回标题test")
    .onBackPressed(() => {
      const popDestinationInfo = this.pathStack.pop() // 弹出路由栈栈顶元素
      console.log('test->pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }

  onPageShow(): void {
    console.log('test->' + this.param.word + '测试参数')
  }
}
