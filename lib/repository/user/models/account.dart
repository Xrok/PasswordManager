class Account {
  Account(this.webPage, this.username, this.password);

  String webPage;
  String username;
  String password;

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      json['webPage'],
      json['username'],
      json['password'],
    );
  }
}
