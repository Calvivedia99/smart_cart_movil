import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cart_movil/data/services/usuario_service.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';
import 'package:smart_cart_movil/modules/auth/screens/login_screen.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/home_body_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = "Usuario";
  String? userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId != null) {
      final usuario = await UsuarioService.obtener(userId);
      if (usuario != null && usuario.perfil != null) {
        setState(() {
          userName = usuario.perfil!.nombre;
          if (usuario.urlFoto != null && usuario.urlFoto!.trim().isNotEmpty) {
            String foto = usuario.urlFoto!.replaceAll(RegExp(r'^/+'), '');
            if (foto.startsWith('media/')) {
              foto = foto.substring('media/'.length);
            }
            userPhotoUrl =
                "${ApiConfig.baseUrl.replaceAll('/api', '')}/media/$foto";
          } else {
            userPhotoUrl = null;
          }
        });
      }
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white12),
              child: Text(
                'SmartCart Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.white),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomNav(),
      body: HomeBodyContent(
        userName: userName,
        userPhotoUrl: userPhotoUrl,
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }
}
