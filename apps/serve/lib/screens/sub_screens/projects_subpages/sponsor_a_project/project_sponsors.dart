import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/sponsors/handlers/sponsor_handlers.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/sponsor_card.dart';
import 'package:serve_to_be_free/widgets/ui/sponsor_card.dart';

import '../../../../models/ModelProvider.dart';

class ProjectSponsors extends StatefulWidget {
  final String projectId;

  const ProjectSponsors({Key? key, required this.projectId}) : super(key: key);

  @override
  _ProjectSponsorsState createState() => _ProjectSponsorsState();
}

class _ProjectSponsorsState extends State<ProjectSponsors> {
  UProject _project = UProject(
      name: '',
      privacy: '',
      description: '',
      projectPicture: '',
      isCompleted: false);
  bool _isLoading = false;
  List<USponsor?> sponsors = [];
  List<String> checkedInSponsorIds = [];

  @override
  void initState() {
    super.initState();
    _fetchProjectData();
  }

  Future<void> _fetchProjectData() async {
    // Simulating asynchronous data fetching
    setState(() {
      _isLoading = true;
    });
    // Assume fetchData() is an asynchronous method in UProject class
    // UProject? project = await ProjectHandlers.getUProjectById(widget.projectId);
    List<USponsor?> usponsors =
        // await SponsorHandlers.getUSponsorsByProject(widget.projectId);
        await SponsorHandlers.getUSponsorsByProject(widget.projectId) ?? [];

    setState(() {
      sponsors.addAll(usponsors);
      // sponsors = sortByDate(sponsors);

      _isLoading = false;
    });
  }

  // static List<USponsor?> sortByDate(List<USponsor?> sponsors) {
  //   // Remove null values from the list before sorting
  //   sponsors.removeWhere((sponsor) => sponsor == null);

  //   // Sort the sponsors by date
  //   sponsors.sort((a, b) {
  //     DateTime dateA = _parseDate(a!.date!);
  //     DateTime dateB = _parseDate(b!.date!);
  //     return dateA.compareTo(dateB);
  //   });

  //   return sponsors;
  // }

  // static DateTime _parseDate(String dateString) {
  //   // Split the date string by '-' and convert to integers
  //   List<int> dateParts = dateString.split('-').map(int.parse).toList();
  //   return DateTime(dateParts[0], dateParts[1], dateParts[2]);
  // }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Sponsors'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Define the behavior when the back button is pressed
            // For example, navigate back to the previous screen
            context.pushNamed("projectdetails", queryParameters: {
              'id': widget.projectId,
            }, pathParameters: {
              'id': widget.projectId,
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? const Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 150.0, // Set height
                        width: 150.0, // Set width
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : sponsors.isNotEmpty
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: sponsors.length,
                        itemBuilder: (context, index) {
                          // if (DateTime.now().isBefore(
                          //         _parseDate(sponsors[index]!.date ?? '')) ||
                          //     DateTime.now()
                          //             .difference(
                          //                 _parseDate(sponsors[index]!.date ?? ''))
                          //             .inHours <
                          //         24) {
                          print(sponsors);
                          return ProjectSponsorCard(
                            id: sponsors[index]!.id,
                            name:
                                '${sponsors[index]!.user!.firstName} ${sponsors[index]!.user!.lastName}',
                            sponsorAmount: sponsors[index]!.amount,
                            profURL: sponsors[index]!.user!.profilePictureUrl!,
                            userId: sponsors[index]!.user!.id,

                            // dateString: sponsors[index]!.date ?? '',
                            // timeString: sponsors[index]!.time ?? '',
                            // name: sponsors[index]!.name,
                            // sponsorId: sponsors[index]!.id,
                            // checkInButon:
                            //     (SponsorHandlers.isSponsorActiveFromUSponsor(
                            //             sponsors[index]!) &&
                            //         !checkedInSponsorIds
                            //             .contains(sponsors[index]!.id) &&
                            //         memberStatus == "ATTENDING"),
                            // memberStatus: memberStatus,
                            // projId: widget.projectId,
                            // sponsorCode: sponsors[index]!.checkInCode ?? "0000",
                            // sponsorAuthorized: (sponsors[index]!.uSponsorOwnerId ==
                            //         BlocProvider.of<UserCubit>(context)
                            //             .state
                            //             .id)
                            //     ? true
                            //     : false,
                          );
                          // }
                        }) // Display message if no sponsors are found
                    : Text('No sponsors found.'),
          ],
        ),
      ),
    );
  }
}
