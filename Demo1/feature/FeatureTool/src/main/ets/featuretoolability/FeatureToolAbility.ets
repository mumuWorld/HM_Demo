import { AbilityConstant, common, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class FeatureToolAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    console.log("test->打开onCreate: ", want.action, want.parameters)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    console.log("test->打开onWindowStageCreate:", this.launchWant.action, this.launchWant.parameters)
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    console.log("test->打开onWindowStageDestroy", this.launchWant.action, this.launchWant.parameters)
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    console.log("test->打开onForeground:", this.launchWant.action, this.launchWant.parameters)
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onContinue(wantParam: Record<string, Object>): AbilityConstant.OnContinueResult | Promise<AbilityConstant.OnContinueResult> {
    console.log("test->打开onContinue:", this.launchWant.action, wantParam["key1"])

    return AbilityConstant.OnContinueResult.AGREE
  }
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.log("test->打开onNewWant:", want.action, want.parameters?.["key1"])

  }

  onBackground(): void {
    console.log("test->打开onBackground:", this.launchWant.action, this.launchWant.parameters)
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');

    // let ctx = getContext(this) as common.UIAbilityContext
    // ctx.terminateSelf()
  }
}
