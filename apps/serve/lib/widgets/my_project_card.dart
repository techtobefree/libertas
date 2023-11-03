import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyProjectCard extends StatelessWidget {
  final String projectName;
  final String id;
  final String projectPhoto;

  const MyProjectCard({
    Key? key,
    required this.projectName,
    required this.id,
    required this.projectPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
      child: SizedBox(
        height: 100,
        child: GestureDetector(
          onTap: () {
            context.goNamed("projectdetails",
                queryParameters: {'id': id}, pathParameters: {'id': id});
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (projectPhoto.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/curious_lemur.jpeg',
                        image: projectPhoto,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                  ),
                Expanded(
                  // Use Expanded widget here
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      projectName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
