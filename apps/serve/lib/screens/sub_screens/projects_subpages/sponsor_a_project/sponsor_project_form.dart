import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';

class SponsorProjectForm extends StatefulWidget {
  final String? projectId;

  const SponsorProjectForm({Key? key, required this.projectId})
      : super(key: key);

  @override
  SponsorProjectFormState createState() => SponsorProjectFormState();
}

class SponsorProjectFormState extends State<SponsorProjectForm> {
  Map<String, dynamic> projectData = {};
  final TextEditingController _amountController = TextEditingController();

  void _submitSponsorship() async {
    final amount = double.parse(_amountController.text);
    final userId = BlocProvider.of<UserCubit>(context).state.id;

    final sponsorData = {
      'amount': amount,
      'user': userId,
    };

    ProjectHandlers.addSponsor(widget.projectId!, sponsorData);

    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sponsorship Submitted'),
        content: const Text('Thank you for sponsoring this project!'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);

              // Navigate back to sponsor projects list
              context.go('/projects/sponsorprojects');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // unused
  //void _showConfirmationModal() {
  //  showDialog(
  //    context: context,
  //    builder: (context) => AlertDialog(
  //      title: const Text('Confirm Sponsorship'),
  //      content:
  //          const Text('Are you sure you want to submit this sponsorship?'),
  //      actions: [
  //        TextButton(
  //          onPressed: () {
  //            goRouter.pop(context); // Close the confirmation dialog
  //            _submitSponsorship(); // Perform the sponsorship submission
  //          },
  //          child: const Text('Yes'),
  //        ),
  //        TextButton(
  //          onPressed: () {
  //            goRouter.pop(context); // Use goRouter.pop to navigate back
  //          },
  //          child: const Text('No'),
  //        ),
  //      ],
  //    ),
  //  );
  //}

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
        backgroundColor: const Color.fromARGB(255, 16, 34, 65),
        title: const Text('Sponsor A Project'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              if (projectData.containsKey('projectPicture') &&
                  projectData['projectPicture'].isNotEmpty)
                Image.network(
                  projectData['projectPicture'],
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              const SizedBox(height: 20),
              Text(
                projectData['name'] ?? '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              if (projectData.containsKey('description'))
                Center(
                  child: Text(
                    '${projectData['description']}',
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    labelText: 'Sponsorship Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitSponsorship,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 16, 34, 65),
                  ),
                ),
                child: const Text('Submit Sponsorship'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
