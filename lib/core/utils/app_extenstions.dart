import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveNamed(String routeName, RoutePredicate predicate,
      {Object? arguments}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }
  Future<dynamic> pushAndRemoveUntil(MaterialPageRoute route,RoutePredicate predicate){
    return Navigator.of(this).pushAndRemoveUntil(route, predicate);
  }

  void pop() {
    return Navigator.of(this).pop();
  }
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == '';
}

extension ListExtention on List? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
