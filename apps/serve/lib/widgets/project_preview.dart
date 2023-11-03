import 'package:flutter/material.dart';

class ProjectPreview extends StatelessWidget {
  final double _dimension;
  final String _imageString;

  // Might need to give this a path property so it goes to the right page depending on where you click on it?
  const ProjectPreview(this._dimension, this._imageString, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _dimension,
      height: _dimension,
      clipBehavior: Clip.hardEdge,
      // This could be dynamic just in case because we dont want hard margins on this.
      margin: const EdgeInsets.all(10),
      // not sure why it was throwing an error but it works now.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      // foregroundDecoration: BoxDecoration(
      //   border: Border.all(color: _borderColor, width: 3),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(_imageString),
      ),
    );
  }
}
