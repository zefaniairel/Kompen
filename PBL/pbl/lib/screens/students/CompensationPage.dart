import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/providers/CompensationProvider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/widgets/BottomNav.dart';

class CompensationPage extends ConsumerWidget {
  CompensationPage({Key? key}) : super(key: key);

  Future<void> _refreshData(WidgetRef ref) async {
    await ref.read(compensationProvider.notifier).getCompensations();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compensationData = ref.watch(compensationProvider);

    if (compensationData == null || compensationData.isEmpty) {
      // Jika data kompensasi kosong, muat ulang
      ref.read(compensationProvider.notifier).getCompensations();

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text('Daftar Compensation',
            style: MyTypography.headline2.copyWith(color: Colors.white)),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(ref),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView.builder(
            itemCount: compensationData.length,
            itemBuilder: (context, index) {
              final compensation = compensationData[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detail-compensation',
                      arguments: compensation.id);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MyColors.accentColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        compensation.judulTugas,
                        style: MyTypography.headline3
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Dosen: ${compensation.dosen}',
                        style: MyTypography.bodyText1
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Periode: ${compensation.periode}',
                            style: MyTypography.bodyText1
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            'Bobot: ${compensation.bobot}',
                            style: MyTypography.bodyText1
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(role: 'mahasiswa', index: 2),
    );
  }
}
