class AuthRepository{
  Future<void> login() async{
    print('attempying login');
    await Future.delayed(Duration(seconds: 3));
    print('logged in');
    throw Exception('Some error occurred');
  }
}