import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../widgets/project_preview.dart';

class LeadAProject extends StatelessWidget {
  const LeadAProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lead A Project Demo'),
        ),
        body: Container(child: Text("Lead a project") //ProjectPreview(),
            ));
  }
}
