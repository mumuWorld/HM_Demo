

export interface  PageRouterParam {
  source: string
  dictParam?: object
}

export class PageRouterParamMdoel implements PageRouterParam {
  /*来源*/
  source: string = ""

  dictParam?: object
  // param: any
  constructor(param?: PageRouterParam) {
    this.source = param?.source ?? ""
    this.dictParam = param?.dictParam
  }
}