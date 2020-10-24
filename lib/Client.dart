
class Client {
  final int id;
  final String famile;
  final String name;
  final String phone;
  final String ll;
  final String rl;

  Client({this.id, this.famile, this.name, this.phone, this.ll, this.rl});
  void display(){
        print("Name: $name Famile: $famile");
    }
}
