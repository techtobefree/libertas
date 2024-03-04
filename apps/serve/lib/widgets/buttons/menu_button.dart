import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuButton extends StatelessWidget {
  final Widget _icon;
  final String _text;
  final String _path;
  final Function()?
      onTapReplacement; // Optional parameter for replacement function
  const MenuButton(this._icon, this._text, this._path,
      {this.onTapReplacement, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapReplacement ??
          () {
            context.go(_path);
          },
      child: Row(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.all(20),
            child: Container(
              child: _icon,
            ),
          ),
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
        ],
      ),
    );
  }
}
