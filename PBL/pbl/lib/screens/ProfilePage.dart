import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/providers/AuthProvider.dart';
import 'package:mobile/providers/CompetenceProvider.dart';
import 'package:mobile/providers/ProdiProvider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/notifiers/CompetenceNotifier.dart';
import 'package:mobile/notifiers/ProdiNotifier.dart';
import 'package:mobile/notifiers/AuthNotifier.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _imagePicker = ImagePicker();
  XFile? _image;

  late int selectedKompetensi;
  late int selectedProdi;

  final TextEditingController _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(competenceProvider.notifier).getCompetences();
      ref.read(prodiProvider.notifier).getProdi();
      ref.read(authProvider.notifier).me();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final competence = ref.watch(competenceProvider);
    final prodi = ref.watch(prodiProvider);

    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    selectedKompetensi = user.idKompetensi!;
    selectedProdi = user.idProdi!;
    _namaController.text = user.nama ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text('Edit Profile',
            style: MyTypography.headline2.copyWith(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path))
                      : NetworkImage(user.fotoProfile ?? '') as ImageProvider,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle:
                      MyTypography.bodyText2.copyWith(color: Colors.black),
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: user.username,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      MyTypography.bodyText2.copyWith(color: Colors.black),
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: user.role,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle:
                      MyTypography.bodyText2.copyWith(color: Colors.black),
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 16),
              if (user.role == 'mahasiswa') ...[
                TextFormField(
                  initialValue: user.semester?.toString() ?? '',
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Semester',
                    labelStyle:
                        MyTypography.bodyText2.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: MyColors.surfaceColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: selectedKompetensi,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedKompetensi = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Kompetensi',
                    labelStyle:
                        MyTypography.bodyText2.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: MyColors.surfaceColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  items: competence?.map<DropdownMenuItem<int>>((competence) {
                    return DropdownMenuItem<int>( 
                      value: competence.id,
                      child: Text(competence.nama),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: selectedProdi,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedProdi = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Prodi',
                    labelStyle:
                        MyTypography.bodyText2.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: MyColors.surfaceColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  items: prodi?.map<DropdownMenuItem<int>>((prodi) {
                    return DropdownMenuItem<int>(
                      value: prodi.id,
                      child: Text(prodi.nama),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
              ],
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _updateProfile,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: MyColors.accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('Update Profile',
                              style: MyTypography.bodyText1
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _logout,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: MyColors.errorColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('Logout',
                              style: MyTypography.bodyText1
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  void _updateProfile() async {
    final user = ref.read(authProvider);
    final nama = _namaController.text;

    try {
      await ref.read(authProvider.notifier).updateProfile(
        nama: nama,
        username: user?.username ?? '',
        prodiId: selectedProdi,
        kompetensiId: selectedKompetensi,
        semester: user?.semester ?? 1,
        alfa: user?.alfa ?? 0,
        compensation: user?.compensation ?? 0,
        fotoProfile: _image != null ? File(_image!.path).path : null,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  void _logout() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Logged out')));
  }
}