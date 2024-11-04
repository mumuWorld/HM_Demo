export class DictResponse {
  simple?:           Simple;
  ec?: ECDict
  blng_sents_part?:  BlngSentsPart
}

export class Simple {
  query?: string;
  word?:  SimpleWord[];
}

export class SimpleWord {
  usphone?:         string;
  ukphone?:         string;
  ukspeech?:        string;

  "return-phrase"?: string;
  // multiPhone?:      MultiPhone;
  usspeech?:        string;

  constructor() {
  }
}

export class  ECDict {
  web_trans?: string[];
  special?:   SpecialElement[];
  word?:      EcWord;
}

export class SpecialElement {
  nat?:   string;
  major?: string;
}

export class EcWord {
  usphone?:         string;
  ukphone?:         string;
  ukspeech?:        string;
  trs?:             PurpleTr[];
  wfs?:             PurpleWf[];
  "return-phrase"?: string;
  usspeech?:        string;
}

export class PurpleTr {
  pos?:  string;
  tran?: string;
}

export class PurpleWf {
  wf?: WfWf;
}

export class WfWf {
  name?:  string;
  value?: string;
}


// mark: 句子

export class BlngSentsPart {
  sentenceCount?: number;
  sentencePair?: SentencePair[];
  more?: string;
  trsClassify?: TrsClassify[];

  static parseJson(str: string): BlngSentsPart {
    let tmpBsp: BlngSentsPart = JSON.parse(str)

    let bsp = new BlngSentsPart()
    bsp.sentenceCount = tmpBsp.sentenceCount
    bsp.sentencePair = tmpBsp.sentencePair?.map((pair) => {
      let p = new SentencePair()
      p.sentence = pair.sentence
      p.sentenceEng = pair.sentenceEng
      p.sentenceTranslation = pair.sentenceTranslation
      p.source = pair.source
      p.url = pair.url
      return p
    })
    bsp.more = tmpBsp.more
    bsp.trsClassify = tmpBsp.trsClassify

    return bsp
  }
  // static fromJSON(jsonString: string): BlngSentsPart {
  //   const jsonObject: { [key: string]: any } = JSON.parse(jsonString);  // 改为具体的对象类型
  //   const instance = new BlngSentsPart();
  //   instance.sentenceCount = jsonObject["sentence-count"];
  //   instance.sentencePair = jsonObject["sentence-pair"]?.map((pair: any) => SentencePair.fromJSON(pair));
  //   instance.more = jsonObject["more"];
  //   instance.trsClassify = jsonObject["trs-classify"]?.map((classify: any) => TrsClassify.fromJSON(classify));
  //
  //   return instance;
  // }
}


export class SentencePair {
  sentence?: string;
  sentenceEng?: string;
  sentenceTranslation?: string;
  // speechSize?: string;
  // alignedWords?: AlignedWords; // 如果 AlignedWords 类存在，可以添加解析
  source?: string;
  url?: string;
  // sentenceSpeech?: string;
  // hlts?: HighLightText[]

  parseAndHighlightText(): HighLightText[] {
    console.log("test->准备解析：",this.sentenceEng, ",send:", this.sentence)
    const regex = /<b>(.*?)<\/b>/g; // 匹配 <b> 标签内容的正则表达式
    // let match = this.sentenceEng?.exec(regex)
    let match = this.sentenceEng?.match(regex)
    const result = match?.[0].replace(/<\/?b>/g, "") ?? ""
    console.log("test-> 匹配高亮: ",result)

    let htls = this.sentence?.split(" ").map((item) => {
      let hlt = new HighLightText()
      hlt.str = item
      hlt.isHighLight = item.includes(result)
      return hlt
    })
    return htls ?? []
  }
}

export class  TrsClassify {
  proportion?: string;
  tr?:         string;

}

export class HighLightText {
  str?: string
  isHighLight: boolean = false
}

