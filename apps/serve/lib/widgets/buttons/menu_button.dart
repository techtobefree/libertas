import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';

class MenuButton extends StatelessWidget {
  // get an icon in here? or a profile picture?
  final Widget _icon;
  final String _text;
  final String _path;
  const MenuButton(this._icon, this._text, this._path);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // handle tap event
          context.go(_path);
        },
        child: Container(
            child: Container(
                child: Row(children: [
          Container(

              // This keeps stretching the profile photo for some reason. Gonna figure out what may cause that.
              width: 80,
              padding: EdgeInsets.all(20),
              child: Container(
                child: _icon,
              )),
          Container(
              child: Text(
            _text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: 'Comic Sans MS',
            ),
          )),
          Spacer(),
          Container(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )
        ]))));
  }
}
