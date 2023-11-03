import 'package:flutter/material.dart';

class MyAccountInfoRow extends StatelessWidget {
  final String subject;
  final String? value;

  const MyAccountInfoRow({
    Key? key,
    required this.subject,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              subject,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 14,
              ),
            ),
          ),
          value != null
              ? Expanded(
                  child: Text(
                    value!,
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Add this line to limit the length of the string
                    maxLines: 1,
                  ),
                )
              : Expanded(
                  child: Text(
                    subject,
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Add this line to limit the length of the string
                    maxLines: 1,
                  ),
                )
        ],
      ),
    );
  }
}
