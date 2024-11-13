import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'Task.dart';

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
  late bool _isOpen; // Tambahkan variabel untuk status
  String? _selectedStatus;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    // Extract the status from title (e.g., "Jenis Tugas : Penelitian" -> "Penelitian")
    _selectedStatus = widget.task.title.split(': ').length > 1
        ? widget.task.title.split(': ')[1]
        : null;

    // Inisialisasi controllers dengan data yang ada
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

    // Inisialisasi nama file dari data sebelumnya
    _fileName = widget.task.fileName;
    _isOpen = widget.task.isOpen; // Inisialisasi status
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
                _buildDateField('First Deadline', _deadlineAwalController),
                SizedBox(height: 16),
                _buildDateField('Last Deadline', _deadlineAkhirController),
                SizedBox(height: 16),
                _buildTextField('Tag kompetensi', _tagKompetensiController),
                SizedBox(height: 16),
                _buildFileUploadSection(),
                SizedBox(height: 20),
                SizedBox(height: 16),
                _buildStatusToggle(),
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

  Widget _buildStatusToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status Tugas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isOpen ? 'Terbuka' : 'Ditutup',
                style: TextStyle(
                  color: _isOpen ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: _isOpen,
                onChanged: (bool value) {
                  setState(() {
                    _isOpen = value;
                  });
                },
                activeColor: Colors.green,
                activeTrackColor: Colors.green.shade200,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.red.shade200,
              ),
            ],
          ),
          Text(
            _isOpen
                ? 'Mahasiswa dapat mengajukan diri untuk tugas ini'
                : 'Mahasiswa tidak dapat mengajukan diri untuk tugas ini',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB0C4DE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_fileName != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'File saat ini: $_fileName',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _fileName != null
                        ? 'Ganti file?'
                        : 'Belum ada file yang dipilih',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text(_fileName != null ? 'Ganti File' : 'Pilih File'),
                  onPressed: _pickFile,
                ),
                if (_fileName != null)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _fileName = null;
                      });
                    },
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
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
        progress: widget.task.progress,
        jumlahMahasiswa: int.parse(_jumlahMahasiswaController.text),
        nilaiJam: int.parse(_nilaiJamKompenController.text),
        tagKompetensi: _tagKompetensiController.text,
        namaKompen: _namaKompenController.text,
        fileName: _fileName,
        isOpen: _isOpen, // Tambahkan status saat menyimpan
      );

      Navigator.of(context).pop(editedTask);
    }
  }
}
