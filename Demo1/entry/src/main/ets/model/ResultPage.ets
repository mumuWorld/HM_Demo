import { LengthMetrics, router, window } from "@kit.ArkUI";
import {
  BlngSentsPart,
  DictResponse,
  ECDict,
  MusicSents,
  PurpleTr,
  SentencePair,
  SentsDatum,
  SimpleWord,
  TrsClassify
} from "./DictModel";
import { PhoneButton } from '../Views/PhoneButton';
import { NaviBar } from '../Views/NaviBar';
import { PageRouterParam } from './RouterModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import webview from '@ohos.web.webview';
import util from '@ohos.util';
import { SentenceCell } from '../Views/SentenceCell';
import { MusicCell } from '../Views/MusicCell';


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
    let jStr =
      "{\"simple\":{\"query\":\"good\",\"word\":[{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\",\"collegeExamVoice\":{\"speechWord\":\"good\"}}]}}"
    let _dict: DictResponse = JSON.parse(jStr)
    console.log("test->1111", this.dict?.simple?.query)

    let ecStr =
      "{\"web_trans\":[\"好的\",\"善\",\"良好\"],\"special\":[{\"nat\":\"善\",\"major\":\"法学\"},{\"nat\":\"善\",\"major\":\"文学\"},{\"nat\":\"好\",\"major\":\"语言学\"}],\"exam_type\":[\"初中\",\"高中\",\"CET4\",\"CET6\",\"考研\"],\"source\":{\"name\":\"有道词典\",\"url\":\"https://dict.youdao.com\"},\"word\":{\"usphone\":\"ɡʊd\",\"ukphone\":\"ɡʊd\",\"ukspeech\":\"good&type=1\",\"trs\":[{\"pos\":\"adj.\",\"tran\":\"优良的；能干的，擅长的；令人愉快的，满意的；合适的，方便的；有益的；乖的；虔诚的；健康的；善良的；正直的；相当大的，相当多的；至少；彻底的；明智的，合理的；划算的，收益可观的；赢得赞许的，令人尊敬的；（用于表示回应）好的；表示惊讶、生气或者加强语气；（用于打招呼）好；有趣的；有效的；能提供……的；（踢、射、投）命中；亲密的；<非正式>够了\"},{\"pos\":\"n.\",\"tran\":\"善，正义；好事；商品，所有物；<英>（运载的）货物（goods）；优势，利益；<非正式>真货，正品（the goods）；好人，有道德的人（the good）\"},{\"pos\":\"adv.\",\"tran\":\"<非正式>好地；<美>彻底地，完全地\"},{\"tran\":\"【名】 （Good）（英）古德，（瑞典）戈德（人名）\"}],\"wfs\":[{\"wf\":{\"name\":\"复数\",\"value\":\"goods\"}},{\"wf\":{\"name\":\"比较级\",\"value\":\"better\"}},{\"wf\":{\"name\":\"最高级\",\"value\":\"best\"}}],\"return-phrase\":\"good\",\"usspeech\":\"good&type=2\"}}"
    let ec: ECDict = JSON.parse(ecStr)
    _dict.ec = ec

    let blng_sents_part_str =
      "{\"sentenceCount\":6,\"sentencePair\":[{\"sentence\":\"I'm good at French.\",\"sentenceEng\":\"I'm <b>good</b> at French.\",\"sentenceTranslation\":\"我的法语很好。\",\"speech-size\":\"5kb\",\"aligned-words\":{\"src\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"2\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"2\",\"@e\":\"4\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"2\"}]},\"@id\":\"1\"},{\"@s\":\"5\",\"@e\":\"9\",\"aligns\":{\"sc\":[{\"@id\":\"2\"}],\"tc\":[{\"@id\":\"3\"}]},\"@id\":\"2\"},{\"@s\":\"10\",\"@e\":\"19\",\"aligns\":{\"sc\":[{\"@id\":\"3\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"3\"}]},\"tran\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"2\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"3\",\"@e\":\"5\",\"aligns\":{\"sc\":[{\"@id\":\"3\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"1\"},{\"@s\":\"5\",\"@e\":\"6\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"2\"}]},\"@id\":\"2\"},{\"@s\":\"6\",\"@e\":\"7\",\"aligns\":{\"sc\":[{\"@id\":\"2\"}],\"tc\":[{\"@id\":\"3\"}]},\"@id\":\"3\"}]}},\"source\":\"《牛津词典》\",\"url\":\"https://《牛津词典》/\",\"sentence-speech\":\"I%27m+good+at+French.&le=eng\"},{\"sentence\":\"I'm going to write good jokes and become a good comedian.\",\"sentenceEng\":\"I'm going to write <b>good</b> jokes and become a <b>good</b> comedian.\",\"sentenceTranslation\":\"我要创作出好的笑话并且成为一个优秀的喜剧演员。\",\"speech-size\":\"16kb\",\"aligned-words\":{\"src\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"4\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"5\",\"@e\":\"13\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"1\"},{\"@s\":\"14\",\"@e\":\"19\",\"aligns\":{\"sc\":[{\"@id\":\"2\"}],\"tc\":[{\"@id\":\"2\"}]},\"@id\":\"2\"},{\"@s\":\"20\",\"@e\":\"24\",\"aligns\":{\"sc\":[{\"@id\":\"3\"}],\"tc\":[{\"@id\":\"3\"}]},\"@id\":\"3\"},{\"@s\":\"25\",\"@e\":\"30\",\"aligns\":{\"sc\":[{\"@id\":\"4\"}],\"tc\":[{\"@id\":\"4\"}]},\"@id\":\"4\"},{\"@s\":\"31\",\"@e\":\"34\",\"aligns\":{\"sc\":[{\"@id\":\"5\"}],\"tc\":[{\"@id\":\"5\"}]},\"@id\":\"5\"},{\"@s\":\"35\",\"@e\":\"41\",\"aligns\":{\"sc\":[{\"@id\":\"6\"}],\"tc\":[{\"@id\":\"6\"}]},\"@id\":\"6\"},{\"@s\":\"42\",\"@e\":\"43\",\"aligns\":{\"sc\":[{\"@id\":\"7\"}],\"tc\":[{\"@id\":\"7\"}]},\"@id\":\"7\"},{\"@s\":\"44\",\"@e\":\"48\",\"aligns\":{\"sc\":[{\"@id\":\"8\"}],\"tc\":[{\"@id\":\"8\"}]},\"@id\":\"8\"},{\"@s\":\"49\",\"@e\":\"57\",\"aligns\":{\"sc\":[{\"@id\":\"9\"}],\"tc\":[{\"@id\":\"9\"}]},\"@id\":\"9\"}]},\"tran\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"2\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"2\",\"@e\":\"3\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"1\"},{\"@s\":\"3\",\"@e\":\"6\",\"aligns\":{\"sc\":[{\"@id\":\"2\"}],\"tc\":[{\"@id\":\"2\"}]},\"@id\":\"2\"},{\"@s\":\"6\",\"@e\":\"8\",\"aligns\":{\"sc\":[{\"@id\":\"3\"}],\"tc\":[{\"@id\":\"3\"}]},\"@id\":\"3\"},{\"@s\":\"8\",\"@e\":\"10\",\"aligns\":{\"sc\":[{\"@id\":\"4\"}],\"tc\":[{\"@id\":\"4\"}]},\"@id\":\"4\"},{\"@s\":\"10\",\"@e\":\"12\",\"aligns\":{\"sc\":[{\"@id\":\"5\"}],\"tc\":[{\"@id\":\"5\"}]},\"@id\":\"5\"},{\"@s\":\"12\",\"@e\":\"14\",\"aligns\":{\"sc\":[{\"@id\":\"6\"}],\"tc\":[{\"@id\":\"6\"}]},\"@id\":\"6\"},{\"@s\":\"14\",\"@e\":\"16\",\"aligns\":{\"sc\":[{\"@id\":\"7\"}],\"tc\":[{\"@id\":\"7\"}]},\"@id\":\"7\"},{\"@s\":\"16\",\"@e\":\"18\",\"aligns\":{\"sc\":[{\"@id\":\"8\"}],\"tc\":[{\"@id\":\"8\"}]},\"@id\":\"8\"},{\"@s\":\"19\",\"@e\":\"23\",\"aligns\":{\"sc\":[{\"@id\":\"9\"}],\"tc\":[{\"@id\":\"9\"}]},\"@id\":\"9\"}]}},\"source\":\"《柯林斯英汉双解大词典》\",\"url\":\"https://《柯林斯英汉双解大词典》/\",\"sentence-speech\":\"I%27m+going+to+write+good+jokes+and+become+a+good+comedian.&le=eng\"},{\"sentence\":\"He's sensationally good-looking!\",\"sentenceEng\":\"He's sensationally <b>good</b>-looking!\",\"sentenceTranslation\":\"他长得太帅了！\",\"speech-size\":\"9kb\",\"aligned-words\":{\"src\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"3\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"6\",\"@e\":\"32\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"1\"}]},\"tran\":{\"chars\":[{\"@s\":\"1\",\"@e\":\"2\",\"aligns\":{\"sc\":[{\"@id\":\"0\"}],\"tc\":[{\"@id\":\"0\"}]},\"@id\":\"0\"},{\"@s\":\"5\",\"@e\":\"6\",\"aligns\":{\"sc\":[{\"@id\":\"1\"}],\"tc\":[{\"@id\":\"1\"}]},\"@id\":\"1\"}]}},\"source\":\"《牛津词典》\",\"url\":\"https://《牛津词典》/\",\"sentence-speech\":\"He%27s+sensationally+good-looking%21&le=eng\"}],\"more\":\"blng_sents\",\"trsClassify\":[{\"proportion\":\"100%\",\"tr\":\"全部\"},{\"proportion\":\"57.8%\",\"tr\":\"好\"},{\"proportion\":\"22.7%\",\"tr\":\"良好\"},{\"proportion\":\"8.4%\",\"tr\":\"很好的\"},{\"proportion\":\"5.4%\",\"tr\":\"不错\"},{\"proportion\":\"2.3%\",\"tr\":\"好处\"},{\"proportion\":\"1.3%\",\"tr\":\"善\"},{\"proportion\":\"1.3%\",\"tr\":\"优良\"},{\"proportion\":\"0.3%\",\"tr\":\"棒\"},{\"proportion\":\"0.3%\",\"tr\":\"利益\"},{\"proportion\":\"0.2%\",\"tr\":\"愉快的\"}]}"
    // let bsp: BlngSentsPart = JSON.parse(blng_sents_part_str)
    let bsp: BlngSentsPart = BlngSentsPart.parseJson(blng_sents_part_str) as BlngSentsPart
    _dict.blng_sents_part = bsp

    let musicStr =
      "{\"sentsData\":[{\"songName\":\"Moon Halo\",\"lyricTranslation\":\"当希望和信念羽翼丰满，就向昨日告别吧\",\"singer\":\"茶理理\",\"coverImg\":\"https://ydlunacommon-cdn.nosdn.127.net/a994cd227f3606739d61d99adee59f4f.jpg?imageView=&type=webp\",\"supportCount\":164,\"lyric\":\"Wave <b>good</b>-bye to the past when hope and faith have grown so strong and sound\",\"lyricList\":[{\"duration\":7040,\"lyricTranslation\":\"当希望和信念羽翼丰满，就向昨日告别吧\",\"lyric\":\"Wave <b>good</b>-bye to the past when hope and faith have grown so strong and sound\",\"start\":0},{\"duration\":4080,\"lyricTranslation\":\"再一次为我张开这双羽翼\",\"lyric\":\"Unfold this pair of wings for me again\",\"start\":7040}],\"id\":\"765ded2022\",\"songId\":\"2BE4FFDDFF93A7B24E65692F888904E1\",\"playUrl\":\"https://dict.youdao.com/dictserver/sentencemusic/playUrl?redirectUrl=https%3A%2F%2Fydlunacommon-cdn.nosdn.127.net%2F7267b9d86fc6eb5dc24f0643aaaaa4f5.mp3\"},{\"songName\":\"Here With You\",\"lyricTranslation\":\"记忆中从未感觉如此美好\",\"singer\":\"Asher Monroe\",\"coverImg\":\"https://ydlunacommon-cdn.nosdn.127.net/517bbf8781b8afd5e3b7a3152501ac4e.jpg?imageView=&type=webp\",\"supportCount\":48,\"lyric\":\"Ain't felt this <b>good</b> since I remember\",\"lyricList\":[{\"duration\":3440,\"lyricTranslation\":\"记忆中从未感觉如此美好\",\"lyric\":\"Ain't felt this <b>good</b> since I remember\",\"start\":0},{\"duration\":3760,\"lyricTranslation\":\"你的到来让今夜变得闪亮\",\"lyric\":\"This night got started when you entered\",\"start\":3440}],\"id\":\"f940ab281d\",\"songId\":\"30D224D8DAA2D89F67C628330C0DA832\",\"playUrl\":\"https://dict.youdao.com/dictserver/sentencemusic/playUrl?redirectUrl=https%3A%2F%2Fydlunacommon-cdn.nosdn.127.net%2Fcfd0512e9511ef977aa2893829df3118.mp3\"},{\"songName\":\"Gravity (feat. JMR)\",\"lyricTranslation\":\"给我一个能让我信服的理由让我接受内心的轻缓迟迟不来的事实\",\"singer\":\"Jai Wolf\",\"coverImg\":\"https://ydlunacommon-cdn.nosdn.127.net/6f364f234bf0674c682a6a55779c8de8.jpg?imageView=&type=webp\",\"supportCount\":48,\"lyric\":\"Then tell me one <b>good</b> reason why the reprieve for heart and mind isn't near us\",\"lyricList\":[{\"duration\":7620,\"lyricTranslation\":\"给我一个能让我信服的理由让我接受内心的轻缓迟迟不来的事实\",\"lyric\":\"Then tell me one <b>good</b> reason why the reprieve for heart and mind isn't near us\",\"start\":0},{\"duration\":2090,\"lyricTranslation\":\"我能听见你灵魂深处的声音\",\"lyric\":\"I hear your voice from the balcony\",\"start\":7620}],\"id\":\"5d0a366732\",\"songId\":\"D04F250D6C9E51849B36FBE1B57F3744\",\"playUrl\":\"https://dict.youdao.com/dictserver/sentencemusic/playUrl?redirectUrl=https%3A%2F%2Fydlunacommon-cdn.nosdn.127.net%2F1ac336bdabc15c53baa466ad972cebe0.mp3\"}],\"more\":true,\"word\":\"good\"}"
    let music: MusicSents = JSON.parse(musicStr)
    _dict.musicSents = music

    this.getLocalJson()

    this.dict = _dict
    this.selectedTrsClassifyTitle = bsp.trsClassify?.[0].tr ?? ""

    let _words: Array<string> = [];
    for (let index = 0; index < 100; index++) {
      _words.push("index: " + index)
    }
    this.words = _words
    // this.sw = _dict.simple?.word?.[0] ?? new SimpleWord()
  }

  getLocalJson() {
    getContext(this).resourceManager.getRawFileContent("json/good.json", (error, data) => {
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
    ListItem() {
      Column({space: CommonConstants.COMMON_MIN_SPACING}) {
        ForEach(this.dict.ec?.word?.trs, (item: PurpleTr) => {
          Row() {
            if (item.pos != null) {
              Text(item.pos)
                .fontSize($r('app.float.middle_font_size'))
                .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
                .width(50)
            }
            Text(item.tran)
              .fontSize($r('app.float.middle_font_size'))
              .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
              .textAlign(TextAlign.Start)
              .flexShrink(1)
          }
          .width(CommonConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Top)

        }, (item: PurpleTr) => JSON.stringify(item.tran))
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .width(CommonConstants.FULL_WIDTH)
    }
  }

  @State selectedTrsClassifyTitle: string = ""

  // 设置例句
  @Builder
  createSentence() {
    ListItem() {
      Column({ space: 16 }) {
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(16), cross: LengthMetrics.px(16) } }) {
          ForEach(this.dict.blng_sents_part?.trsClassify, (item: TrsClassify) => {
            Button(item.tr, { type: ButtonType.Normal })
              .fontSize(14)
              .onClick(() => {
                  this.selectedTrsClassifyTitle = item.tr ?? "出错"
              })
              .height(30)
              .borderRadius(10)
              .backgroundColor(this.selectedTrsClassifyTitle == item.tr ? Color.Red : Color.Gray)
          })
        }
        .margin({ bottom: 20 })

        ForEach(this.dict.blng_sents_part?.sentencePair, (item: SentencePair) => {
          SentenceCell({item: item})
        })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 20 })
    }
  }

  @Builder
  createMusic() {
    ListItem() {
      Column({space: CommonConstants.COMMON_SPACING}) {
        Text("音乐例句")
          .fontSize(20)
          .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
          .margin({ bottom: 16 })

        ForEach(this.dict.musicSents?.sentsData, (sentence: SentsDatum) => {
          MusicCell({sentence: sentence})
        })

        Row() {
          Button({ type: ButtonType.Normal }) {
            Row() {
              Text("查看更多")
            }
          }
          .padding({left: 10, right: 10})
          .backgroundColor(Color.Gray)
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  tabContentBuilder(item: string, index: number) {
    TabContent() {
      List({ space: CommonConstants.LIST_SPACE, scroller: this.scrollerForList }) {
        this.createTrans()
        this.createSentence()
        this.createMusic()
      }
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
      Web({ src: "https://baidu.com/", controller: this.webviewController, renderMode: RenderMode.ASYNC_RENDER })
    }
    .tabBar(this.tabBuilder(index, item))
  }

  build() {
    Column() {
      NaviBar({backTitle: this.source, showBack: true})
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
            PhoneButton({sw: this.dict.simple?.word?.[0]})
              .margin({ top: $r("app.float.common_spacing") })

            Tabs() {
              ForEach(["简明", "牛津", "新牛津"], (item: string, index: number) => {
                if (index == 0) {
                  this.tabContentBuilder(item, index)
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
        .padding({bottom: this.bottomArea + 20})
      }
      .width(CommonConstants.FULL_WIDTH)
      .height("calc(100% - 80vp)")

    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)

  }

  onPageShow(): void {
    console.log('test->' + this.dict.simple?.query + '测试参数')
  }
}
