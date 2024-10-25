import { ResultPage, ResultPageParam } from './ResultPage';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State word: string = '';
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string, param: ResultPageParam) {
    if (name == 'ResultPage') {
      ResultPage({param: param})
    }
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Navigation(this.pageStack) {
        TextInput({ placeholder: "输入查询单词", text: this.word })
          .onSubmit((type) => {
            if (this.word.length < 1) {
              return
            }
            let param = new ResultPageParam()
            param.word = this.word
            this.pageStack.pushPath({ name: "ResultPage", param: param })
          })
        Button('跳转')
          .onClick(()=>{
            let param = new ResultPageParam()
            param.word = "test"
            this.pageStack.pushPath({ name: "ResultPage", param: param })
          })
      }
      .mode(NavigationMode.Stack)
      .navDestination(this.PagesMap)


    }
    .height('100%')
    .width('100%')
  }
}
