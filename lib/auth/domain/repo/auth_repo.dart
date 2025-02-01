abstract class AuthRepo<T> {
  Future<T> login({required String email, required String password});
}
