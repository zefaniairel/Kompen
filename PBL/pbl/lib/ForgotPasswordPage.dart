import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1F2739),
              Color(0xFF2A324B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Top Left Curve
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A324B),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            // Bottom Right Curve
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2739),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            // Icon Back
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(
                      context); // Kembali ke halaman sebelumnya (LoginPage)
                },
              ),
            ),
            // Main Content Positioned
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 7),
                  const Text(
                    'KOMPEN',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Jurusan Teknologi Informasi',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(flex: 2),
                  // Forgot Password Card
                  Container(
                    width: 350,
                    child: Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ForgotPasswordForm(),
                      ),
                    ),
                  ),
                  const Spacer(flex: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _nipController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _selectedDate;
  bool _isSuccess = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _resetPassword() {
    String nip = _nipController.text;
    String email = _emailController.text;

    // Validasi inputan
    if (nip.isEmpty || _selectedDate == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi semua field')),
      );
      return;
    }

    // Validasi format email
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid')),
      );
      return;
    }

    // Validasi NIP (misalnya hanya angka dan panjang tertentu)
    if (!RegExp(r'^\d{10}$').hasMatch(nip)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIP harus terdiri dari 10 digit angka')),
      );
      return;
    }

    // Simulasi proses reset password
    setState(() {
      _isSuccess = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reset Password Berhasil!')),
    );

    // Optionally, navigasi kembali ke LoginPage setelah beberapa detik
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // NIP Field
        TextField(
          controller: _nipController,
          decoration: const InputDecoration(
            labelText: 'NIP',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        // Date of Birth Field
        TextField(
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: 'Tanggal Lahir',
            border: const OutlineInputBorder(),
            hintText: _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : 'Pilih tanggal lahir',
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        ),
        const SizedBox(height: 10),
        // Email Field
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // Reset Button
        ElevatedButton(
          onPressed: _resetPassword,
          child: const Text('Reset Password'),
        ),
        const SizedBox(height: 10),
        // Informasi Reset
        if (_isSuccess)
          const Text(
            'Password berhasil direset!',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
