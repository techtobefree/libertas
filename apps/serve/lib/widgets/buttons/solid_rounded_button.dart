import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SolidRoundedButton extends StatelessWidget {
  final String _label;
  final String? _path;
  final VoidCallback _passedFunction;

  SolidRoundedButton(
    this._label, {
    VoidCallback? passedFunction,
    String? path,
  })  : _passedFunction = passedFunction ?? (() {}),
        _path = path ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.lightBlue[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            _label,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        onPressed: () {
          if (_path != '') {
            context.go(_path!);
          } else {
            _passedFunction();
          }
        },
      ),
    );
  }
}
