class ChikyuNotifier {
  void myNotifyListeners(){

  }
}

class LoggedInState implements ChikyuNotifier{
  LoggedInState(this.isLoggedIn);
  bool isLoggedIn;

  @override
  void myNotifyListeners(){

  }

  void login(){
    isLoggedIn = true;
    myNotifyListeners();
  }
  void logout(){
    isLoggedIn = false;
    myNotifyListeners();
  }
}

