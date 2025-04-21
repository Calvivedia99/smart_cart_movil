// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_cart_movil/data/services/auth_service.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _firstNameController =
      TextEditingController(); // Para nombre completo
  final TextEditingController _lastNameController =
      TextEditingController(); // Para apellido completo

  File? _image;
  bool _isLoading = false;
  String? _error;
  bool _isImagePickerActive = false;

  final picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    if (_isImagePickerActive) return;
    setState(() {
      _isImagePickerActive = true;
    });

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    setState(() {
      _isImagePickerActive = false;
    });
  }

  // Function to handle user registration
  void _register() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Validation for empty fields
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _firstNameController.text.isEmpty || // Check for first name
        _lastNameController.text.isEmpty) {
      // Check for last name
      setState(() {
        _error = "Todos los campos son obligatorios";
        _isLoading = false;
      });
      return;
    }

    // Password validation
    if (_passwordController.text.length < 6) {
      setState(() {
        _error = "La contraseña debe tener al menos 6 caracteres";
        _isLoading = false;
      });
      return;
    }

    // Generate the image file name: phone + user.name + lastName
    String imageName =
        "${_phoneController.text.trim()}_${_nameController.text.trim()}_${_lastNameController.text.trim()}.jpg";

    // If an image is picked, save it with the new name
    if (_image != null) {
      File newImage = await _image!.rename('${_image!.parent.path}/$imageName');
      // Updating the image with the new name
      _image = newImage;
    }

    // Prepare the data for registration
    final data = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "url_foto": _image != null ? _image!.path : "", // Optional profile image
      "nombre": _firstNameController.text.trim(), // Correctly assign first name
      "apellido": _lastNameController.text.trim(), // Correctly assign last name
      "telefono": _phoneController.text.trim(),
      "sexo": _genderController.text.trim(),
    };

    // Register the user by calling AuthService
    final response = await AuthService.register(data);

    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      final userId = response['data']['user_id'];
      print("Usuario registrado con ID: $userId");

      // Navigate to CrearPerfilScreen
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } else {
      setState(() => _error = response['error']);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REGISTRARSE",
                style: GoogleFonts.bebasNeue(fontSize: 45, color: Colors.white),
              ),
              const SizedBox(height: 40),
              _CustomInput(
                label: "Nombre de Usuario",
                controller: _nameController,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              _CustomInput(
                label: "Correo",
                controller: _emailController,
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              _CustomInput(
                label: "Contraseña",
                controller: _passwordController,
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              _CustomInput(
                label: "Teléfono",
                controller: _phoneController,
                icon: Icons.phone,
              ),
              const SizedBox(height: 20),
              _CustomInput(
                label: "Nombre Completo",
                controller: _firstNameController,
                icon: Icons.account_circle,
              ),
              const SizedBox(height: 20),
              _CustomInput(
                label: "Apellido Completo",
                controller: _lastNameController,
                icon: Icons.account_circle,
              ),
              const SizedBox(height: 20),
              // Gender selection dropdown
              DropdownButtonFormField<String>(
                value:
                    _genderController.text.isEmpty
                        ? null
                        : _genderController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    _genderController.text = newValue!;
                  });
                },
                items:
                    <String>['M', 'F'].map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                decoration: InputDecoration(
                  labelText: "Sexo",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white10,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Optional profile image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      _image == null
                          ? Center(
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          )
                          : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Registrarse"),
                  ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                child: const Text(
                  "¿Ya tienes cuenta? Inicia sesión aquí",
                  style: TextStyle(
                    color: Colors.white70,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.redAccent)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;

  const _CustomInput({
    required this.label,
    required this.controller,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white10,
      ),
    );
  }
}
