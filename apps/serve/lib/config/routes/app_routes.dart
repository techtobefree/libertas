// import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/models/UProject.dart';
import 'package:serve_to_be_free/screens/community_pledge.dart';
import 'package:serve_to_be_free/screens/information.dart';
import 'package:serve_to_be_free/screens/signup.dart';
import 'package:serve_to_be_free/screens/dashboard.dart';
import 'package:serve_to_be_free/screens/groups.dart';
import 'package:serve_to_be_free/screens/login.dart';
import 'package:serve_to_be_free/screens/menu.dart';
import 'package:serve_to_be_free/screens/messages.dart';
import 'package:serve_to_be_free/screens/notifications.dart';
import 'package:serve_to_be_free/screens/profile.dart';
import 'package:serve_to_be_free/screens/projects.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/about_group.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/find_a_group.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/find_group_project.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/group_details.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/group_details_form.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/group_projects.dart';
import 'package:serve_to_be_free/screens/sub_screens/groups_subpages/show_group_members.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/active_events.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/friends.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/checked_in.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/event_details_form.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/past_events.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/qr_display.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/qr_scan.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/sponsor_a_project/project_sponsors.dart';
import 'package:serve_to_be_free/screens/sub_screens/signup_subpages/choose_profile_picture.dart';
import 'package:serve_to_be_free/screens/sub_screens/signup_subpages/confirm_email.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/how_it_works.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/my_account_subpages/my_account_contact_info.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/my_account_subpages/my_account_emergency_info.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/my_account_subpages/my_account_general_info.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/my_account_subpages/my_account_login_info.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/create_a_project/invite_a_leader.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/sponsor_a_project/sponsor_project_form.dart';
import 'package:serve_to_be_free/screens/sub_screens/welcome_sub.dart';
import 'package:serve_to_be_free/screens/sub_screens/welcome_sub2.dart';
import 'package:serve_to_be_free/screens/sub_screens/welcome_sub3.dart';
import 'package:serve_to_be_free/screens/welcome.dart';
import 'package:serve_to_be_free/screens/tasks.dart';
import 'package:serve_to_be_free/screens/sub_screens/create_a_post.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/about_page.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/my_account.dart';
import 'package:serve_to_be_free/screens/sub_screens/menu_subpages/edit_profile.dart';

import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/create_a_project/project_details_form.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/create_a_project/create_a_project.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/lead_a_project.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/project_details.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/project_events.dart';

import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/about_project.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/event_details.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/my_projects.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/show_project_members.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/show_members_attending.dart';

import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/lead_project_details.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/sponsor_a_project.dart';
import 'package:serve_to_be_free/widgets/ui/my_scaffold.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/find_a_project.dart';
import 'package:serve_to_be_free/screens/sub_screens/projects_subpages/finish_projects.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/welcome',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/welcome',
      pageBuilder: ((context, state) =>
          const NoTransitionPage(child: WelcomeScreen())),
    ),
    GoRoute(
      path: '/newwelcome',
      pageBuilder: ((context, state) =>
          const NoTransitionPage(child: NewUserWelcome())),
    ),
    GoRoute(
      path: '/newwelcome2',
      pageBuilder: ((context, state) =>
          const NoTransitionPage(child: NewUserWelcome2())),
    ),
    GoRoute(
      path: '/newwelcome3',
      pageBuilder: ((context, state) =>
          const NoTransitionPage(child: NewUserWelcome3())),
    ),
    GoRoute(
      path: '/information',
      name: 'information',
      pageBuilder: (context, state) => NoTransitionPage(
        child: Information(
          title: state.queryParameters['title'],
          info: state.queryParameters['info'],
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginScreen()),
      routes: [
        GoRoute(
          path: 'createaccountscreen',
          builder: (context, state) => const CreateAccountScreen(),
          routes: [
            GoRoute(
                path: 'chooseprofilepicture',
                builder: (context, state) => const ChooseProfilePicture(),
                routes: [
                  GoRoute(
                    path: 'confirmemail',
                    name: 'confirmemail',
                    builder: (context, state) => const ConfirmationCodePage(),
                  ),
                ]),
          ],
        ),
        GoRoute(
          path: 'communitypledge',
          builder: (context, state) => const CommunityPledge(
            agreedToPledge: false,
          ),
        )
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        /*
        We need to use this scaffold to maintain our Bottom Nav and then wrap
        the other widgets with a normal scaffold to specify the appbar header.
        */
        return MyScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardPage(/*label: 'A', detailsPath: '/a/details'*/),
          ),
          routes: [
            GoRoute(
              path: 'createapost',
              builder: (context, state) => const CreateAPost(),
            ),
          ],
        ),
        GoRoute(
          path: '/projects',
          pageBuilder: (context, state) => const NoTransitionPage(
              // eventually we add a way to see all projects from a different profile.
              child: ProjectsPage(
            myProjectsPath: '/projects/myprojects',
            findProjectsPath: '/projects/findprojects',
            createProjectsPath: '/projects/createprojects',
            leadProjectsPath: '/projects/leadprojects',
            sponsorProjectsPath: '/projects/sponsorprojects',
          )),
          routes: [
            GoRoute(
              path: 'findprojects',
              builder: (context, state) => const FindAProject(/*label: 'B'*/),
            ),
            GoRoute(
                path: 'createprojects',
                builder: (context, state) => const CreateAProject(
                    '/projects/createprojects/projectdetailsform'),
                routes: [
                  GoRoute(
                      path: 'projectdetailsform',
                      name: 'projectdetailsform',
                      builder: (context, state) => ProjectDetailsForm(
                          path:
                              '/projects/createprojects/projectdetailsform/invitealeader',
                          id: state.queryParameters['id']),
                      routes: [
                        GoRoute(
                            path: 'invitealeader',
                            builder: (context, state) => const InviteALeader(
                                path:
                                    '/projects/createprojects/projectdetailsform/invitealeader/projectroles'))
                      ])
                ]),
            GoRoute(
              path: 'leadprojects',
              builder: (context, state) => const LeadAProject(/*label: 'B'*/),
            ),
            GoRoute(
                path: 'sponsorprojects',
                builder: (context, state) =>
                    const SponsorAProject(/*label: 'B'*/),
                routes: [
                  GoRoute(
                    path: 'sponsorprojectform:id',
                    name: 'sponsorprojectform',
                    builder: (context, state) => SponsorProjectForm(
                        projectId: state.queryParameters['id']),
                  ),
                ]),
            GoRoute(
              path: 'myprojects',
              builder: (context, state) => const MyProjects(),
            ),
            GoRoute(
              path: 'projectdetails/:id',
              name: 'projectdetails',
              builder: (context, state) =>
                  ProjectDetails(id: state.queryParameters['id']),
            ),
            GoRoute(
              path: 'projectsponsors',
              name: 'projectsponsors',
              builder: (context, state) => ProjectSponsors(
                  projectId: state.queryParameters['projectId']!),
            ),
            GoRoute(
              path: 'leadprojectdetails/:id',
              name: 'leadprojectdetails',
              builder: (context, state) =>
                  LeadProjectDetails(id: state.queryParameters['id']),
            ),
            GoRoute(
              path: 'eventdetails/:id',
              name: 'eventdetails',
              builder: (context, state) => EventDetailsPage(
                eventId: state.queryParameters['id']!,
              ),
            ),
            GoRoute(
              path: 'qrdisplay/:code',
              name: 'qrdisplay',
              builder: (context, state) => QRDisplay(
                code: state.queryParameters['code']!,
              ),
            ),
            GoRoute(
              path: 'checkedin',
              name: 'checkedin',
              builder: (context, state) => CheckedIn(
                eventId: state.queryParameters['eventId']!,
              ),
            ),
            GoRoute(
              path: 'qrscan/:code',
              name: 'qrscan',
              builder: (context, state) => QRScan(
                code: state.queryParameters['code']!,
                eventId: state.queryParameters['eventId']!,
              ),
            ),
            GoRoute(
              path: 'projectevents/:projectId',
              name: 'projectevents',
              builder: (context, state) =>
                  ProjectEvents(projectId: state.queryParameters['projectId']!),
            ),
            GoRoute(
              path: 'pastevents/:projectId',
              name: 'pastevents',
              builder: (context, state) =>
                  PastEvents(projectId: state.queryParameters['projectId']!),
            ),
            GoRoute(
              path: 'projectabout/:id',
              name: 'projectabout',
              builder: (context, state) =>
                  AboutProject(id: state.queryParameters['id']!),
            ),
            GoRoute(
              path: 'eventdetailsform/:projectId',
              name: 'eventdetailsform',
              builder: (context, state) => EventDetailsForm(
                projectId: state.queryParameters['projectId']!,
                eventId: state.queryParameters['eventId'] ?? '',
              ),
            ),
            GoRoute(
              path: 'showmembers',
              name: 'showmembers',
              builder: (context, state) => ShowProjectMembers(
                projectId: state.queryParameters['projectId'],
              ),
            ),
            GoRoute(
              path: 'showmembersattending',
              name: 'showmembersattending',
              builder: (context, state) => ShowMembersAttending(
                eventId: state.queryParameters['eventId'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/groups',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: GroupsPage(/*label: 'B', detailsPath: '/b/details'*/),
          ),
          routes: [
            GoRoute(
              path: 'groupsdetailsform',
              name: 'groupsdetailsform',
              builder: (context, state) =>
                  GroupDetailsForm(id: state.queryParameters['id'] ?? ""),
            ),
            GoRoute(
              path: 'findagroup',
              name: 'findagroup',
              builder: (context, state) => const FindAGroup(),
            ),
            GoRoute(
              path: 'groupdetails/:id',
              name: 'groupdetails',
              builder: (context, state) =>
                  GroupDetails(id: state.queryParameters['id']),
            ),
            GoRoute(
              path: 'groupabout/:id',
              name: 'groupabout',
              builder: (context, state) =>
                  AboutGroup(id: state.queryParameters['id']!),
            ),
            GoRoute(
              path: 'groupprojects/:id',
              name: 'groupproject',
              builder: (context, state) =>
                  GroupProjects(id: state.queryParameters['id']!),
            ),
            GoRoute(
              path: 'findgroupproject/:id',
              name: 'findgroupproject',
              builder: (context, state) =>
                  FindAGroupProject(id: state.queryParameters['id']!),
            ),
            GoRoute(
              path: 'showgroupmembers',
              name: 'showgroupmembers',
              builder: (context, state) => ShowGroupMembers(
                groupId: state.queryParameters['groupId'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/mytasks',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TasksPage(/*label: 'B', detailsPath: '/b/details'*/),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'details',
          //     builder: (context, state) => const DetailsScreen(label: 'B'),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/notifications',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: NotificationsPage(/*label: 'B', detailsPath: '/b/details'*/),
          ),
        ),
        GoRoute(
          path: '/mymessages',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MessagesPage(/*label: 'B', detailsPath: '/b/details'*/),
          ),
          // routes: [
          //   GoRoute(
          //     path: 'details',
          //     builder: (context, state) => const DetailsScreen(label: 'B'),
          //   ),
          // ],
        ),
        GoRoute(
          path: '/menu',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MenuPage(
              myProfilePath: '/menu/myprofile',
              finishProjectsPath: '/menu/finishprojects',
              //favoritesPath: '/menu/createprojects',
              howItWorksPath: '/menu/howitworks',
              aboutPath: '/menu/aboutservetobefree',
            ),
          ),
          routes: [
            GoRoute(
                path: 'myprofile',
                name: 'profile',
                builder: (context, state) =>
                    Profile(id: state.queryParameters['id']),
                routes: [
                  GoRoute(
                      path: 'editprofile',
                      name: 'editprofile',
                      builder: (context, state) => EditProfile())
                ]),
            GoRoute(
              path: 'friends/:userId',
              name: 'friends',
              builder: (context, state) => Friends(
                userId: state.queryParameters['userId'],
              ),
            ),
            GoRoute(
              path: 'communitypledge',
              name: 'communitypledgemenu',
              builder: (context, state) => const CommunityPledge(
                agreedToPledge: true,
              ),
            ),
            GoRoute(
              path: 'myevents/:userId',
              name: 'myevents',
              builder: (context, state) => MyEvents(
                userId: state.queryParameters['userId'],
              ),
            ),
            GoRoute(
              path: 'finishprojects',
              builder: (context, state) => const FinishProject(),
            ),
            GoRoute(
                path: 'myaccount',
                builder: (context, state) => const MyAccount(
                      generalInfoPath: '/menu/myaccount/generalinfo',
                      contactInfoPath: '/menu/myaccount/contactinfo',
                      emergencyInfoPath: '/menu/myaccount/emergencyinfo',
                      loginInfoPath: '/menu/myaccount/logininfo',
                    ),
                routes: [
                  GoRoute(
                      path: 'generalinfo',
                      builder: (context, state) =>
                          const MyAccountGeneralInfo()),
                  GoRoute(
                      path: 'emergencyinfo',
                      builder: (context, state) =>
                          const MyAccountEmergencyInfo()),
                  GoRoute(
                      path: 'logininfo',
                      builder: (context, state) => const MyAccountLoginInfo()),
                  GoRoute(
                      path: 'contactinfo',
                      builder: (context, state) => const MyAccountContactInfo())
                ]),
            GoRoute(
              path: 'howitworks',
              builder: (context, state) => const HowItWorksPage(/*label: 'B'*/),
            ),
            GoRoute(
              path: 'aboutservetobefree',
              builder: (context, state) => const AboutPage(/*label: 'B'*/),
            ),
          ],
        ),
      ],
    ),
  ],
);

// use like this:
// MaterialApp.router(routerConfig: goRouter, ...)