export class DictResponse {
  simple?:           Simple;
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
//
// export interface MultiPhone {
//   uk?: Uk[];
// }