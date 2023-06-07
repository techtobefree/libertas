import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SponsorCard extends StatelessWidget {
  const SponsorCard({super.key});

  // this is going to need to take an image
  // going to need text as well "Featured sponsor, POINTS, if sponsored by Chickfila"
  // Can take

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Container(
          height: 150,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.all(15),
                      child: Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/chick-fil-a-logo-2.jpg'),
                          //fit: BoxFit.cover,
                        ),
                      ))),
                  Expanded(
                      child: Container(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          "FEATURED SPONSOR BONUS",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "75 Bonus Points",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1),
                        ),
                      ),
                      Container(
                          child: Text(
                        "when you join any project sponsored by Chick-Fil-A",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ))
                    ],
                  )))
                ],
              )),
        ));
  }
}
