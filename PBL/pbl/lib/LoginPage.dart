import 'package:flutter/material.dart';
import 'package:pbl/BerandaDosenPage.dart';
import 'package:pbl/ForgotPasswordPage.dart'; // Import ForgotPasswordPage

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    'Jurusan Teknologi Informasi 1',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    width: 350,
                    child: Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: LoginForm(),
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

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;

  final List<String> _roles = ['Mahasiswa', 'Dosen', 'Tendik'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Username Field
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        // Password Field
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        // Role Selection Dropdown
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Sebagai',
            border: OutlineInputBorder(),
          ),
          value: _selectedRole,
          items: _roles.map((String role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
        ),
        const SizedBox(height: 20),
        // Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // Navigasi ke halaman Lupa Password
                Navigator.pushNamed(
                    context, '/password'); // Update route '/password'
              },
              child: const Text('Lupa Password?'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logika untuk login
                String username = _usernameController.text;
                String password = _passwordController.text;
                String? role = _selectedRole;

                if (username.isEmpty || password.isEmpty || role == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Harap lengkapi semua field')),
                  );
                  return;
                }

                // Simulasi autentikasi berhasil
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login sebagai $role berhasil!')),
                );

                // Navigasi ke MainScreen
                Navigator.pushReplacementNamed(context, '/main');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
