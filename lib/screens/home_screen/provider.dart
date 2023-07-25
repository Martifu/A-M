import 'dart:math';

import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<String> imageLinks = [
    'https://images.unsplash.com/photo-1648198835769-96dd560071b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1065&q=80',
    'https://images.unsplash.com/photo-1490723186985-6d7672633c86?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2369&q=80',
    'https://images.unsplash.com/photo-1426543881949-cbd9a76740a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
  ];

  String currentImageLink1 = '';
  String currentImageLink2 = '';
  String currentImageLink3 = '';

  initImages() {
    _changeImage1();
    _changeImage2();
    _changeImage3();
    // // Start the timer to change images every 2 seconds
    // Timer.periodic(
    //     const Duration(milliseconds: 4000), (Timer timer) => _changeImage1());
    // Timer.periodic(
    //     const Duration(milliseconds: 2000), (Timer timer) => _changeImage2());
    // Timer.periodic(
    //     const Duration(milliseconds: 5000), (Timer timer) => _changeImage3());
  }

  void _changeImage1() {
    // Generate a random index to pick a random image link from the list
    int randomIndex = Random().nextInt(imageLinks.length);
    currentImageLink1 = imageLinks[randomIndex];
    notifyListeners();
  }

  void _changeImage2() {
    // Generate a random index to pick a random image link from the list
    int randomIndex = Random().nextInt(imageLinks.length);
    currentImageLink2 = imageLinks[randomIndex];
    notifyListeners();
  }

  void _changeImage3() {
    // Generate a random index to pick a random image link from the list
    int randomIndex = Random().nextInt(imageLinks.length);
    currentImageLink3 = imageLinks[randomIndex];
    notifyListeners();
  }
}
