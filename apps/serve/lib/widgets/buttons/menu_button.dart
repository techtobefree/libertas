import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuButton extends StatelessWidget {
  // get an icon in here? or a profile picture?
  final Widget _icon;
  final String _text;
  final String _path;
  const MenuButton(this._icon, this._text, this._path, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // handle tap event
          context.go(_path);
        },
        child: Row(children: [
          Container(

              // This keeps stretching the profile photo for some reason. Gonna figure out what may cause that.
              width: 80,
              padding: const EdgeInsets.all(20),
              child: Container(
                child: _icon,
              )),
          Text(
            _text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: 'Comic Sans MS',
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ]));
  }
}
