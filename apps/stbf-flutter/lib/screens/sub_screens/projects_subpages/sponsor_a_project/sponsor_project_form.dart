import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/config/routes/app_routes.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:provider/provider.dart';

import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

class SponsorProjectForm extends StatefulWidget {
  final String? projectId;

  const SponsorProjectForm({Key? key, required this.projectId})
      : super(key: key);

  @override
  _SponsorProjectFormState createState() => _SponsorProjectFormState();
}

class _SponsorProjectFormState extends State<SponsorProjectForm> {
  Map<String, dynamic> projectData = {};
  TextEditingController _amountController = TextEditingController();

  void _submitSponsorship() async {
    final amount = double.parse(_amountController.text);
    final userId = Provider.of<UserProvider>(context, listen: false).id;

    final sponsorData = {
      'amount': amount,
      'user': userId,
    };

    ProjectHandlers.addSponsor(widget.projectId!, sponsorData);

    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sponsorship Submitted'),
        content: Text('Thank you for sponsoring this project!'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);

              // Navigate back to sponsor projects list
              context.go('/projects/sponsorprojects');
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Sponsorship'),
        content: Text('Are you sure you want to submit this sponsorship?'),
        actions: [
          TextButton(
            onPressed: () {
              goRouter.pop(context); // Close the confirmation dialog
              _submitSponsorship(); // Perform the sponsorship submission
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              goRouter.pop(context); // Use goRouter.pop to navigate back
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ProjectHandlers.getProjectById(widget.projectId).then((data) {
      setState(() {
        projectData = data;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 34, 65),
        title: const Text('Sponsor A Project'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              if (projectData.containsKey('projectPicture') &&
                  projectData['projectPicture'].isNotEmpty)
                Image.network(
                  projectData['projectPicture'],
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              SizedBox(height: 20),
              Text(
                projectData['name'] ?? '',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              if (projectData.containsKey('description'))
                Center(
                  child: Text(
                    '${projectData['description']}',
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(height: 20),
              Container(
                width: 200,
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    labelText: 'Sponsorship Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitSponsorship,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 16, 34, 65),
                  ),
                ),
                child: Text('Submit Sponsorship'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
