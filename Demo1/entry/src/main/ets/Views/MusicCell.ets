import { CommonConstants } from "../common/constants/CommonConstants";
import { SentsDatum } from "../model/DictModel";
import { http } from "@kit.NetworkKit";
import { image } from "@kit.ImageKit";
import { BusinessError } from "@kit.BasicServicesKit";


@Component
export struct MusicCell {

  sentence?: SentsDatum

  @State pixelMapImg: PixelMap | undefined = undefined;

  aboutToAppear(): void {
    console.log("test->请求图片")
    this.requestImgUrl()
  }
  
  requestImgUrl() {
    http.createHttp().request(this.sentence?.coverImg, (error: BusinessError, data: http.HttpResponse) => {
      if (error) {
        console.error(`test->request image failed: url: ${this.sentence?.coverImg}, code: ${error.code}, message: ${error.message}`);
      } else {
        let imgData: ArrayBuffer = data.result as ArrayBuffer;
        console.info(`test-> request image success, size: ${imgData.byteLength}`);
        let imgSource: image.ImageSource = image.createImageSource(imgData);

        class sizeTmp {
          height: number = 50
          width: number = 50
        }

        let options: Record<string, number | boolean | sizeTmp> = {
          'alphaType': 0,
          'editable': false,
          'pixelFormat': 3,
          'scaleMode': 1,
          'size': { height: 50, width: 50 }
        }
        imgSource.createPixelMap(options).then((pixelMap: PixelMap) => {
          console.error('image createPixelMap success');
          this.pixelMapImg = pixelMap;
        })
      }
    })
  }

  build() {
    Column() {
      Row() {
        Image(this.pixelMapImg)
          .height(50)
          .width(50)
          .borderRadius(25)

        Column() {
          Text(this.sentence?.lyric)
            .maxLines(2)
            .margin({bottom:16})
          Text(this.sentence?.lyricTranslation)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: 16})
      }

      Row(){
        Text("去网易云听|"+this.sentence?.songName + " - " + this.sentence?.singer + " >")
        Button(){
          Text(this.sentence?.supportCount?.toString())
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}