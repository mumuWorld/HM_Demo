import { preferences } from "@kit.ArkData";
import { USER_SETTING } from "../common/CommonKey";

export class UserSetting {

  context: Context

  constructor(ctx: Context) {
    this.context = ctx
  }

  getStore() {
    // preferences.getPreferences(this.context, USER_SETTING, (err, pre) => {
    //   pre.get(USER_SETTING)
    // })

    preferences.getPreferences(this.context, {
      name: USER_SETTING
    })
  }
}