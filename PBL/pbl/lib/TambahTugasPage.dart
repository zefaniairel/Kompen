import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
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
                _buildTextField('Masukkan nama kompen', _namaKompenController),
                SizedBox(height: 16),
                _buildDropdownButton(),
                SizedBox(height: 16),
                _buildTextField(
                    'Masukkan deskripsi tugas', _deskripsiController),
                SizedBox(height: 16),
                _buildTextField(
                    'Masukkan jumlah mahasiswa', _jumlahMahasiswaController,
                    isNumber: true),
                SizedBox(height: 16),
                _buildTextField(
                    'Masukkan nilai jam kompen', _nilaiJamKompenController,
                    isNumber: true),
                SizedBox(height: 16),
                _buildDateField(
                    'Masukkan First Deadline', _deadlineAwalController),
                SizedBox(height: 16),
                _buildDateField(
                    'Masukkan Last Deadline', _deadlineAkhirController),
                SizedBox(height: 16),
                _buildTextField(
                    'Masukkan tag kompetensi', _tagKompetensiController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 69, 90, 226),
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
      // Buat objek Task dari data yang diisi
      Task newTask = Task(
        title:
            'Jenis Tugas : $_selectedStatus', // Misalnya bisa ambil dari dropdown
        description: _deskripsiController.text,
        firstDeadline: _deadlineAwalController.text,
        lastDeadline: _deadlineAkhirController.text,
        progress: '0/0', // Atur progress sesuai kebutuhan
        jumlahMahasiswa: int.parse(_jumlahMahasiswaController.text),
        nilaiJam: 0, tagKompetensi: '', namaKompen: '',
      );

      // Kembalikan objek Task ke KompenScreen
      Navigator.of(context).pop(newTask);
    }
  }
}
