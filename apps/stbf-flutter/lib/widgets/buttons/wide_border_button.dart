import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class wideBorderButton extends StatelessWidget {
  /* This is going to be a pointer to whatever function we pass in
  */
  final String _path;
  final Widget _icon;
  final String _label;

  wideBorderButton(this._label, this._icon, this._path);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(width: 2.5, color: Colors.black),
        ),

        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // inherited icon
            _icon,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0, top: 6, bottom: 6),
                child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                      // inherited label
                      _label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    )),
              ),
            ),
          ],
        ),
        // inherited functionality
        onPressed: () {
          context.go(_path);
        },
      ),
    );
  }
}
