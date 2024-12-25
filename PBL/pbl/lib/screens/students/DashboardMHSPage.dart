import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/providers/AuthProvider.dart';
import 'package:mobile/providers/DashboardProvider.dart';
import 'package:mobile/providers/TaskProvider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/widgets/BottomNav.dart';

class DashboardMHSPage extends ConsumerWidget {
  const DashboardMHSPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final user = ref.watch(authProvider);
    final dashboard = ref.watch(dashboardProvider);

    if (dashboard == null) {
      ref.read(dashboardProvider.notifier).getDashboardStudent();
    }

    Future<void> _refresh() async {
      await ref.read(dashboardProvider.notifier).getDashboardStudent();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: dashboard == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _refresh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors.accentColor,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      user?.fotoProfile != null
                                          ? Image.network(user!.fotoProfile!,
                                              height: 50)
                                          : Image.asset(
                                              'assets/images/profile.png',
                                              height: 50,
                                            ),
                                      SizedBox(width: 8),
                                      Text(
                                        user?.nama ?? "Fulan bin Fulan",
                                        style: MyTypography.headline2
                                            .copyWith(color: Colors.white),
                                      )
                                    ]),
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      await authNotifier.logout();
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.logout,
                                    color: MyColors.primaryColor,
                                  ),
                                )
                              ])),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 32) / 3,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: MyColors.accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    dashboard.totalTasks.toString(),
                                    style: MyTypography.headline1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tugas',
                                    style: MyTypography.bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 32) / 3,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: MyColors.accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    dashboard.totalRequests.toString(),
                                    style: MyTypography.headline1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Request',
                                    style: MyTypography.bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 32) / 3,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: MyColors.accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    dashboard.totalCompensations.toString(),
                                    style: MyTypography.headline1
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Kompensasi',
                                    style: MyTypography.bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dashboard.progress.length,
                          itemBuilder: (context, index) {
                            final progress = dashboard.progress[index];
                            return GestureDetector(
                              onTap: () {
                                ref.read(taskProvider.notifier).getTaskStudentById(progress.id);
                                Navigator.pushNamed(context, '/detail-task',
                                    arguments: progress.id);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: MyColors.accentColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          progress.judul,
                                          style: MyTypography.headline3
                                              .copyWith(color: Colors.white),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          progress.dosen,
                                          style: MyTypography.bodyText1
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text("${progress.progress}%",
                                          style: MyTypography.bodyText1
                                              .copyWith(color: Colors.white)),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomNav(role: 'mahasiswa', index: 0),
    );
  }
}
