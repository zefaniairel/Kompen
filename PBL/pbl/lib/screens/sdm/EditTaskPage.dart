import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';

class EditTaskPage extends StatefulWidget {
  final Map<String, dynamic> initialData;

  const EditTaskPage({
    Key? key,
    required this.initialData,
  }) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final TextEditingController judulController;
  late final TextEditingController deskripsiController;
  late final TextEditingController bobotController;
  late final TextEditingController semesterController;
  late final TextEditingController kuotaController;
  late final TextEditingController urlController;

  String? jenisTugas;
  String? tipeInput;
  DateTime? selectedDateTime;

  final List<Map<String, dynamic>> jenisTugasData = [
    {"id": 1, "nama": "Halo"},
    {"id": 2, "nama": "Project"},
    {"id": 3, "nama": "Ujian"}
  ];

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.initialData['judul']);
    deskripsiController =
        TextEditingController(text: widget.initialData['deskripsi']);
    bobotController =
        TextEditingController(text: widget.initialData['bobot']?.toString());
    semesterController =
        TextEditingController(text: widget.initialData['semester']?.toString());
    kuotaController =
        TextEditingController(text: widget.initialData['kuota']?.toString());
    urlController = TextEditingController(text: widget.initialData['url']);

    jenisTugas = widget.initialData['jenisTugas']?.toString();
    tipeInput = widget.initialData['tipeInput'];
    selectedDateTime = widget.initialData['deadline'] != null
        ? DateTime.parse(widget.initialData['deadline'])
        : null;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: selectedDateTime?.hour ?? 0,
          minute: selectedDateTime?.minute ?? 0,
        ),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text('Edit Tugas', style: MyTypography.headline2.copyWith(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: judulController,
                decoration: InputDecoration(
                  labelText: 'Judul Tugas',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Tugas',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: bobotController,
                decoration: InputDecoration(
                  labelText: 'Bobot',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: semesterController,
                decoration: InputDecoration(
                  labelText: 'Semester',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: kuotaController,
                decoration: InputDecoration(
                  labelText: 'Kuota',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: jenisTugas,
                decoration: InputDecoration(
                  labelText: 'Jenis Tugas',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: jenisTugasData
                    .map((e) => DropdownMenuItem(
                          value: e['id'].toString(),
                          child: Text(e['nama']),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    jenisTugas = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: tipeInput,
                decoration: InputDecoration(
                  labelText: 'Tipe Input',
                  filled: true,
                  fillColor: MyColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'file', child: Text('File')),
                  DropdownMenuItem(value: 'url', child: Text('URL')),
                ],
                onChanged: (value) {
                  setState(() {
                    tipeInput = value;
                  });
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDateTime(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    selectedDateTime == null
                        ? 'Pilih Deadline'
                        : '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} - ${selectedDateTime!.hour}:${selectedDateTime!.minute}',
                    style: MyTypography.bodyText2,
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  // Tambahkan fungsi submit di sini
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: MyColors.accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Simpan Tugas',
                    textAlign: TextAlign.center,
                    style: MyTypography.bodyText2.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}