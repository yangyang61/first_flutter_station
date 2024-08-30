class Human {
  String name = '';
  double height = 0;
  double weight = 0;
  Human(String name, double height, double weight) {
    this.name = name;
    this.height = height;
    this.weight = weight;
  }
}

void main() {
  // Human daci = Human();
  Human toly = Human('toly', 180, 63.5);
  // daci.name = 'Daci';
  // daci.height = 178;
  // daci.weight = 65;

  // print(
  // "Human: name{${daci.name},weight:${daci.weight}kg,height:${daci.height}cm}");
  print(
      "Human: name{${toly.name},weight:${toly.weight}kg,height:${toly.height}cm}");
}
