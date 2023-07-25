import 'package:flutter/material.dart';

import '../../models/carta.dart';

class LeerCarta extends StatelessWidget {
  const LeerCarta({super.key});

  @override
  Widget build(BuildContext context) {
    //get carta from arguments
    final Carta carta = ModalRoute.of(context)!.settings.arguments as Carta;
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/carta-textura.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carta.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'visby',
                          fontSize: 25,
                          //italic: true,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      carta.content!,
                      style: const TextStyle(
                          fontFamily: 'visby',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
