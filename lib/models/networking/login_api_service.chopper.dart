part of 'login_api_service.dart';

class _$LoginApiService extends LoginApiService {
  _$LoginApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LoginApiService;

  @override
  Future<Response<dynamic>> getUserInfo({
    String email,
    String password,
    String mode = "app",
  }) {
    final $url = 'FlutterLogin.php';
    final $params = <String, dynamic>{
      'email': email,
      'password': password,
      'mode': mode
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    print("ここにアクセスしにいくよ" + $url);
    print($request.body);
    return client.send<dynamic, dynamic>($request);
  }
}
