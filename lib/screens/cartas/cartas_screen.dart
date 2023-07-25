import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jagvault/constants.dart';

import 'nueva_carta.dart';

class CartasScreen extends StatelessWidget {
  const CartasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('mis cartas',
            style: TextStyle(
                color: primaryColor,
                fontFamily: 'visby',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ),
      body: SizedBox(
        width: size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('m&a')
                      .doc('martin')
                      .collection('letters')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error al obtener los datos');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    // Los datos fueron obtenidos correctamente
                    final data = snapshot.data;

                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: data!.docs.length,
                        itemBuilder: (context, index) {
                          final carta = data.docs[index];
                          return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Stack(
                                children: [
                                  Image.asset("assets/img/carta.png"),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 5),
                                      child: Text(carta.get('title')!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'visby',
                                              color: secondaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ));
                        });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NuevaCarta()));
                  },
                  child: Container(
                    width: size.width * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.fromBorderSide(
                          BorderSide(color: secondaryColor, width: 2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("escribir carta",
                              style: TextStyle(
                                  fontFamily: 'visby',
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            HeroIcons.envelope,
                            color: secondaryColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
