import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 获取cookie中想要的值
String getCookieValue(String cookie, String key) {
  String rex = r'(\w+)=([^;"]+)';
  RegExp r = new RegExp(rex);
  var sp = r.allMatches(cookie);
  String res;
  for(int i=0;i<sp.length;i++){
    if(sp.elementAt(i).group(1) == key) {
      res = sp.elementAt(i).group(2);
    }
  }
  return res;
}

// const baseUrl = "http://dev.cimevue.cn:39193";
String baseUrl;
const uploadApi = "/api/elPerson/photoSearch/upload";
Dio dio;
Future<Dio> getDio(WebViewController wvb) async {
  dio = Dio();
  String currentUrl = await wvb.currentUrl();
  Uri uri = Uri.parse(currentUrl);
  baseUrl = uri.origin;
  dio.interceptors.add(InterceptorsWrapper(
      onRequest: (Options options) async {
// dio.interceptors.requestLock.lock();
        final String cookies = await wvb.evaluateJavascript('document.cookie');
        final token = getCookieValue(cookies, "jw_app_token");
        print("""
        cookies=========>${cookies}, 
        token====>$token
      """);
        options.headers["Authorization"] = token;
// dio.interceptors.requestLock.unlock();
        return options;
      }
  ));
}

Future downloadImage(String url) async {
  return Dio().get(url, options: Options(responseType: ResponseType.bytes));
}

Future uploadFile (String path) async {
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(path)
  });
  Future<dynamic> response = dio.post('$baseUrl$uploadApi', data: formData);
  // {"resultCode":0,"resultMsg":"检测不到人脸","success":false}
  // {"datas":{"imageMd5":"eeb439a88bd84b4885fccbf6bff22b36","imageId":"","zimgNode":"20201201daqvhvek","imageUrl":"/api/v1/getImage//20201201daqvhvek/eeb439a88bd84b4885fccbf6bff22b36","base64Str":"gZksPVc6AD0RDfI8dLJ7vHIpvDzZYtq8WranvMiOr7xnf30802oLvLsEj7zyV4Q8eBTzPJS34Tx7H8i85P8AvZadMT1/wHQ9TVEMvZJt17zyiSG9evpCPUD5iD0bA368Bv94vaiJSbwz+Cc9dZhLPCcE37wdG+s8aZdqvLWvL7y6ESe9XuaBvZJt17x8RE29fx2FO6ZxXDxtlSc8IjGVPCs0Ob10QSm9uLoEPahXrDyCjBQ9hi1BvGa3iDv265i96cUyvasFcbwSjwc9szOIvJL8BLszN928hQi8vN94hLxrr9e8zuMOPdbmMj1Fvzq92fGHOzHgOjyIRS48GmCOvAckfrnVwS09ttQ0PRC2T7xczhQ71fNKvY8jzTmAdCe9LUymvSkPtLwzBUA9TCwHPGWSA71mKFu9AvqRvPShjj3Vj5A92rn8vCIxlb1X3W+8pCdSPcD83TyinhK8fBIwvKIP5bz4AwY8Jd9ZvfgQnjvuJyo9nUkzPXDSmTzobhA7q5SevJDkl7zEXlU7zSJEvDF8gL2DIuy4eOJVPc1hebzobpA8VG7gOtxgl7zkonA72rl8vEFQKz1mKNs8KLgRPPGWOT1F8de7vqW7vEbkv7yz1nc8Bv94vJ08G70enQA79TfmO/ykMr2azQs81Y8QvWG8grwqc+48p4yAvCv1Az378P88TwzpPEqFbLumcVy8LFk+vHVmLj39CO071Y+QvFmRorwzaXo8Z03gPEuqcbu6Eae8RYAFPa4DLrsQhDI7r2doOuRw07v2Ks68b9+xvH8dhT0+4Zu7qXyxPJo+Xrwy06K8ZZKDvRPzwTwgWN
  return response.then((value) {
    print("图片上传成功---===========>");
    return value.data;
  }).catchError((err) {
    print("图片上传失败===========>");
    return {
      "success": "false",
      "data": err.message
    };
  });
}