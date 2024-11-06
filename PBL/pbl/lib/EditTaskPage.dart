import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbl/BerandaDosenPage.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaKompenController;
  late TextEditingController _deskripsiController;
  late TextEditingController _jumlahMahasiswaController;
  late TextEditingController _nilaiJamKompenController;
  late TextEditingController _deadlineAwalController;
  late TextEditingController _deadlineAkhirController;
  late TextEditingController _tagKompetensiController;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    // Extract the status from title (e.g., "Jenis Tugas : Penelitian" -> "Penelitian")
    _selectedStatus = widget.task.title.split(': ').length > 1
        ? widget.task.title.split(': ')[1]
        : null;

    _namaKompenController = TextEditingController(text: widget.task.namaKompen);
    _deskripsiController = TextEditingController(text: widget.task.description);
    _jumlahMahasiswaController =
        TextEditingController(text: widget.task.jumlahMahasiswa.toString());
    _nilaiJamKompenController =
        TextEditingController(text: widget.task.nilaiJam.toString());
    _deadlineAwalController =
        TextEditingController(text: widget.task.firstDeadline);
    _deadlineAkhirController =
        TextEditingController(text: widget.task.lastDeadline);
    _tagKompetensiController =
        TextEditingController(text: widget.task.tagKompetensi);
  }

  @override
  void dispose() {
    _namaKompenController.dispose();
    _deskripsiController.dispose();
    _jumlahMahasiswaController.dispose();
    _nilaiJamKompenController.dispose();
    _deadlineAwalController.dispose();
    _deadlineAkhirController.dispose();
    _tagKompetensiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tugas'),
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
                  child: Text('Simpan Perubahan'),
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
      Task editedTask = Task(
        title: 'Jenis Tugas : $_selectedStatus',
        description: _deskripsiController.text,
        firstDeadline: _deadlineAwalController.text,
        lastDeadline: _deadlineAkhirController.text,
        progress: widget.task.progress, // Maintain existing progress
        jumlahMahasiswa: int.parse(_jumlahMahasiswaController.text),
        nilaiJam: int.parse(_nilaiJamKompenController.text),
        tagKompetensi: _tagKompetensiController.text,
        namaKompen: _namaKompenController.text,
      );

      Navigator.of(context).pop(editedTask);
    }
  }
}
