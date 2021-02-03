import 'package:flutter/material.dart';

class PersonModel {
  int age;
  String name;
  PersonModel(this.name, this.age);

  @override
  String toString() {
    return 'PersonModel{age: $age, name: $name}';
  }
}

class MyModel with ChangeNotifier {

  List<PersonModel> _personList = [];

  void addPerson (PersonModel personModel) {
    _personList.add(personModel);
    notifyListeners();
  }

  void removePerson (PersonModel personModel) {
    _personList.remove(personModel);
    notifyListeners();
  }

  PersonModel getPerson(int index) {
    return _personList[index];
  }
  List<PersonModel> get personList => _personList;

}