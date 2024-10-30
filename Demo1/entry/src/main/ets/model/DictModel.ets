export class DictResponse {
  simple?:           Simple;
  ec?: ECDict
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