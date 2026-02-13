import 'package:olearis_tech_task/utils/result.dart';

class AuthRepository {
  Future<Result<void>> signIn({
    required String login,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const Success(null);
  }
}
