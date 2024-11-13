import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'BerandaDosenPage.dart';

class TambahTugasPage extends StatefulWidget {
  @override
  _TambahTugasPageState createState() => _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaKompenController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _jumlahMahasiswaController = TextEditingController();
  final _nilaiJamKompenController = TextEditingController();
  final _deadlineAwalController = TextEditingController();
  final _deadlineAkhirController = TextEditingController();
  final _tagKompetensiController = TextEditingController();
  String? _selectedStatus;

  // New variables for file handling
  // PlatformFile? _selectedFile;
  // Uint8List? _fileBytes;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Nama kompen', _namaKompenController),
                SizedBox(height: 16),
                _buildDropdownButton(),
                SizedBox(height: 16),
                _buildTextField('Deskripsi tugas', _deskripsiController),
                SizedBox(height: 16),
                _buildTextField('Jumlah mahasiswa', _jumlahMahasiswaController,
                    isNumber: true),
                SizedBox(height: 16),
                _buildTextField('Jumlah jam kompen', _nilaiJamKompenController,
                    isNumber: true),
                SizedBox(height: 16),
                _buildDateField(' First Deadline', _deadlineAwalController),
                SizedBox(height: 16),
                _buildDateField(' Last Deadline', _deadlineAkhirController),
                SizedBox(height: 16),
                _buildTextField('Tag kompetensi', _tagKompetensiController),
                SizedBox(height: 16),
                _buildFileUploadSection(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 2, 2),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _fileName ?? 'Belum ada file yang dipilih',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text('Pilih File'),
                  onPressed: _pickFile,
                ),
              ],
            ),
          ),
          // if (_fileName != null)
          //   Padding(
          //     padding: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         TextButton(
          //           onPressed: _clearFile,
          //           child: Text('Hapus File'),
          //           style: TextButton.styleFrom(
          //             foregroundColor: Colors.red,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      );

      if (result != null) {
        setState(() {
          _fileName = result.files.first.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  // void _clearFile() {
  //   setState(() {
  //     _selectedFile = null;
  //     _fileName = null;
  //   });
  // }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdownButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Pilih jenis tugas kompen',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        ),
        value: _selectedStatus,
        items: <String>['Penelitian', 'Teknis', 'Pengabdian']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedStatus = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih jenis tugas kompen';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            setState(() {
              controller.text = formattedDate;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Masukkan $hintText';
          }
          return null;
        },
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Buat objek Task sesuai dengan model yang ada
      Task newTask = Task(
        title: 'Jenis Tugas : $_selectedStatus',
        description: _deskripsiController.text,
        firstDeadline: _deadlineAwalController.text,
        lastDeadline: _deadlineAkhirController.text,
        progress: '0/0',
        jumlahMahasiswa: int.parse(_jumlahMahasiswaController.text),
        nilaiJam: 0, // sesuai model asli
        tagKompetensi: '', // sesuai model asli
        namaKompen: '', // sesuai model asli
      );

      // Kembali ke halaman sebelumnya dengan data task
      Navigator.of(context).pop(newTask);
    }
  }
}
