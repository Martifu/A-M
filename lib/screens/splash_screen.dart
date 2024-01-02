import 'package:flutter/material.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<AuthenticationService>(context, listen: false);

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    _navigateToNextPage() async {
      //delay 2 seconds to next page
      await Future.delayed(const Duration(seconds: 4), () {});
      try {
        var userData = await authService.getUserData();

        if (userData != null) {
          print("User data: $userData");
          userProvider.loadUser();
          // Si el usuario está conectado y hemos obtenido datos, navegar al Home
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          // Si no hay usuario, navegar al Login
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }

    // Verificar el estado al construir el widget
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToNextPage());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/img/logo_1.gif',
              colorBlendMode: BlendMode.dstOut,
              width: size.width * 0.8,
            ), // Muestra un indicador de carga
          ),
          const SizedBox(height: 10),
          const Text(
            '♥️',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
