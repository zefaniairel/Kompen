import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/providers/AuthProvider.dart';
import 'package:mobile/providers/DashboardProvider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/widgets/BottomNav.dart';

class DashboardSDMPage extends ConsumerWidget {
  const DashboardSDMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final user = ref.watch(authProvider);
    final dashboard = ref.watch(dashboardProvider);

    if (dashboard == null) {
      ref.read(dashboardProvider.notifier).getDashboardSdm();
    }

    Future<void> _refresh() async {
      await ref.read(dashboardProvider.notifier).getDashboardSdm();
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.accentColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                user?.fotoProfile != null
                                    ? Image.network(user!.fotoProfile!,
                                        height: 50)
                                    : Image.asset(
                                        'assets/images/profile.png',
                                        height: 50,
                                      ),
                                const SizedBox(width: 8),
                                Text(
                                  user?.nama ?? "Fulan bin Fulan",
                                  style: MyTypography.headline2
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                try {
                                  await authNotifier.logout();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard(
                                context, dashboard!.totalTasks, 'Tugas'),
                            const SizedBox(width: 8),
                            _buildStatCard(
                                context, dashboard.totalRequests, 'Request'),
                            const SizedBox(width: 8),
                            _buildStatCard(context,
                                dashboard.totalCompensations, 'Kompensasi'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomNav(role: 'sdm', index: 0),
    );
  }

  Widget _buildStatCard(BuildContext context, int count, String label) {
    return Container(
      width: (MediaQuery.of(context).size.width - 32) / 3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.accentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: MyTypography.headline1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: MyTypography.bodyText1.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
