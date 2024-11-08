import { RemoteNotificationExtensionAbility, pushCommon } from '@kit.PushKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

export default class EntryRemoteNotification extends RemoteNotificationExtensionAbility {
  async onReceiveMessage(remoteNotificationInfo: pushCommon.RemoteNotificationInfo):
    Promise<pushCommon.RemoteNotificationContent> {
    hilog.info(0x0000, 'testTag', 'remoteNotificationInfo: %{public}s', JSON.stringify(remoteNotificationInfo));
    return {
      title: 'Default replace title.',
      text: 'Default replace text.',
      badgeNumber: 1,
      wantAgent: {
        abilityName: 'DemoAbility',
        parameters: {
          key: 'Default value'
        }
      }
    }
  }
}