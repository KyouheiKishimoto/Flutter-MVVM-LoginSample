
import 'package:chopper/chopper.dart';

part 'login_api_service.chopper.dart';

@ChopperApi()
abstract class LoginApiService extends ChopperService {
  //定数
  static const BASE_URL = "";

  //Login用のAPI
  static LoginApiService create() {
    final client = ChopperClient(
      baseUrl: BASE_URL,
      services: [
        //情報が存在しているか管理しているクラス
        _$LoginApiService(),
      ],
      converter: JsonConverter(),
    );
    return _$LoginApiService(client);
  }

  @Get(path: "FlutterLogin.php")
  Future<Response> getUserInfo({
    @Query("email") String email,
    @Query("password") String password,
    @Query("mode") String mode = "app",
  });

}
