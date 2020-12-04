import 'package:dio/dio.dart';

//https://blog.csdn.net/yechaoa/article/details/90234708
class HttpUtils {
  static final baseUrl = 'https://www.wanandroid.com/';

  static HttpUtils _instence;

  static HttpUtils getInstance() {
    if (null == _instence) {
      _instence = HttpUtils();
    }
    return _instence;
  }

  Dio _dio;
  BaseOptions _options;

  HttpUtils() {
    _options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      sendTimeout: 30000,
      //请求头
      headers: {},
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
    _dio = Dio(_options);
    //日志拦截器
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print('=============================request============================');
      print('url:${options.uri}');
      print('method ${options.method}');
      print('headers:${options.headers}');
      print('data:\n${options.data}');
      print('queryParameters:\n${options.queryParameters}');
      return options;
    }, onResponse: (Response response) {
      print('=============================response============================');
      print('url:${response.request.uri}');
      print('response:${response.data}');
      return response;
    }, onError: (DioError e) {
      print('Error url:${e.request.uri}');
      return e;
    }));
  }

  /*
   * get请求
   */
  Future<Response> get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
    }
    return response;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
}

