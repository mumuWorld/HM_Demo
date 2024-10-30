import { fileUri } from '@kit.CoreFileKit';
import { resourceManager } from "@kit.LocalizationKit";
import { router, window } from "@kit.ArkUI";
import { DictResponse, ECDict, PurpleTr, SimpleWord } from "../model/DictModel";
import { PhoneButton } from '../Views/PhoneButton';
import { sim } from '@kit.TelephonyKit';
import { NaviBar } from '../Views/NaviBar';
import { PageRouterParam } from '../model/RouterModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import webview from '@ohos.web.webview';


@Entry
@Component
export struct ResultPage {
  @State dict: DictResponse = new DictResponse()
  @State sw: SimpleWord = new SimpleWord()
  @State source: string = ""
  @StorageLink('topArea') topArea: number = 0;
  @StorageLink('bottomArea') bottomArea: number = 0;
  @State words: string[] = []

  getWordData() {
    // str = this.context.get
    // JSON.has()
    // let ctx = getContext(this) as common.UIAbilityContext;
    // let resourceManager = ctx.resourceManager
    let jStr =
      "{\"simple\":{\"query\":\"good\",\"word\":[{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\",\"collegeExamVoice\":{\"speechWord\":\"good\"}}]}}"
    let _dict: DictResponse = JSON.parse(jStr)
    console.log("test->1111", this.dict?.simple?.query)

    let ecStr =
      "{\"web_trans\":[\"好的\",\"善\",\"良好\"],\"special\":[{\"nat\":\"善\",\"major\":\"法学\"},{\"nat\":\"善\",\"major\":\"文学\"},{\"nat\":\"好\",\"major\":\"语言学\"}],\"exam_type\":[\"初中\",\"高中\",\"CET4\",\"CET6\",\"考研\"],\"source\":{\"name\":\"有道词典\",\"url\":\"https://dict.youdao.com\"},\"word\":{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"trs\":[{\"pos\":\"adj.\",\"tran\":\"优良的；能干的，擅长的；令人愉快的，满意的；合适的，方便的；有益的；乖的；虔诚的；健康的；善良的；正直的；相当大的，相当多的；至少；彻底的；明智的，合理的；划算的，收益可观的；赢得赞许的，令人尊敬的；（用于表示回应）好的；表示惊讶、生气或者加强语气；（用于打招呼）好；有趣的；有效的；能提供……的；（踢、射、投）命中；亲密的；<非正式>够了\"},{\"pos\":\"n.\",\"tran\":\"善，正义；好事；商品，所有物；<英>（运载的）货物（goods）；优势，利益；<非正式>真货，正品（the goods）；好人，有道德的人（the good）\"},{\"pos\":\"adv.\",\"tran\":\"<非正式>好地；<美>彻底地，完全地\"},{\"tran\":\"【名】 （Good）（英）古德，（瑞典）戈德（人名）\"}],\"wfs\":[{\"wf\":{\"name\":\"复数\",\"value\":\"goods\"}},{\"wf\":{\"name\":\"比较级\",\"value\":\"better\"}},{\"wf\":{\"name\":\"最高级\",\"value\":\"best\"}}],\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\"}}"
    let ec: ECDict = JSON.parse(ecStr)
    _dict.ec = ec

    this.dict = _dict
    let _words: Array<string> = [];
    for (let index = 0; index < 100; index++) {
      _words.push("index: " + index)
    }
    this.words = _words
    // this.sw = _dict.simple?.word?.[0] ?? new SimpleWord()
  }

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      let area = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.topArea = px2vp(area.topRect.height);
      let bottom = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      this.bottomArea = px2vp(bottom.bottomRect.height);

      console.log("test-> 安全区域高度: ", this.topArea, "底部：", this.bottomArea)
      if (this.topArea > 0) {
        windowStage.setWindowLayoutFullScreen(true);
      }
    });
    let p: PageRouterParam = router.getParams() as PageRouterParam
    this.source = p.source
    console.log("test-> appear 收到参数2" + p.toString())
    this.getWordData()
  }

  pathStack: NavPathStack = new NavPathStack()
  baseSpacing: number = 16
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();
  private webviewController: WebviewController = new webview.WebviewController()
  @State currentIndex: number = 0;

  @Builder
  tabBuilder(index: number, name: ResourceStr) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? Color.Red : "#182431")
        .fontSize($r('app.float.middle_font_size'))
        .fontWeight(this.currentIndex === index ? CommonConstants.FONT_WEIGHT_FIVE : CommonConstants.FONT_WEIGHT_FOUR)
        .lineHeight($r('app.float.title_line_height'))
        .padding({
          top: $r('app.float.title_margin_top'),
          bottom: $r('app.float.title_margin_bottom')
        })
      Divider()
        .strokeWidth(CommonConstants.STROKE_WIDTH)
        .width($r('app.float.divider_width'))
        .color(Color.Red)
        .opacity(this.currentIndex === index ? CommonConstants.FULL_OPACITY : CommonConstants.ZERO_OPACITY)
    }
  }

  @Builder
  createTrans() {
    ForEach(this.dict.ec?.word?.trs, (item: PurpleTr) => {
      ListItem() {
        Row() {
          if (item.pos != null) {
            Text(item.pos)
              .fontSize($r('app.float.middle_font_size'))
              .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
              .width(60)
          }
          Text(item.tran)
            .fontSize($r('app.float.middle_font_size'))
            .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Top)
    }
    }, (item: PurpleTr) => JSON.stringify(item.tran))
  }

  @Builder
  listBuilder(item: string, index: number) {
    TabContent() {
      List({ space: CommonConstants.LIST_SPACE, scroller: this.scrollerForList }) {
        this.createTrans()

        // ForEach(this.words, (rowName: string) => {
        //   ListItem() {
        //     Row() {
        //       Text(item)
        //         .fontSize($r('app.float.middle_font_size'))
        //         .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
        //       Text(rowName)
        //         .fontSize($r('app.float.middle_font_size'))
        //         .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
        //     }
        //     .padding({ left: $r('app.float.list_item_padding') })
        //     .backgroundColor(Color.White)
        //     .width(CommonConstants.FULL_WIDTH)
        //     .height(CommonConstants.FULL_HEIGHT)
        //     .borderRadius($r('app.float.list_item_radius'))
        //
        //   }
        //   .width(CommonConstants.FULL_WIDTH)
        //   .height($r('app.float.list_item_height'))
        // }, (item: string) => JSON.stringify(item))
      }
      .padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding')
      })
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
    }
    .tabBar(this.tabBuilder(index, item))
  }

  @Builder
  listWebBuilder(item: string, index: number) {
    TabContent() {
      Web({ src: "https://www.example.com/", controller: this.webviewController, renderMode: RenderMode.ASYNC_RENDER })
    }
    .tabBar(this.tabBuilder(index, item))
  }

  build() {
    Column() {
      NaviBar(this.source)
        .height(44)
        .margin({ top: this.topArea })

      Text(this.dict.simple?.query)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
      Blank()
        .color(Color.Black)
        .height(1)

      Stack({ alignContent: Alignment.Top }) {
        Scroll(this.scrollerForScroll) {
          Column() {
            PhoneButton(this.dict.simple?.word?.[0] ?? new SimpleWord())
              .margin({ top: $r("app.float.common_spacing") })

            Tabs() {
              ForEach(["简明", "牛津", "新牛津"], (item: string, index: number) => {
                if (index == 0) {
                  this.listBuilder(item, index)
                } else {
                  this.listWebBuilder(item, index)
                }
              })
            }
            .align(Alignment.Start)
            .barMode(BarMode.Scrollable)
            .barWidth($r('app.float.bar_width'))
            .onAnimationStart((_index: number, targetIndex: number, _event: TabsAnimationEvent) => {
              this.currentIndex = targetIndex;
            })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.STACK_HEIGHT)

    }
    .padding({ left: $r("app.float.common_spacing"), right: $r("app.float.common_spacing") })
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Green)

  }

  onPageShow(): void {
    console.log('test->' + this.dict.simple?.query + '测试参数')
  }
}
