import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jagvault/constants.dart';
import 'package:jagvault/models/carta.dart';
import 'package:jagvault/screens/cartas/leer_carta.dart';
import 'package:jagvault/screens/home_screen/provider.dart';
import 'package:jagvault/screens/recuerdos/recuerdos_screen.dart';
import 'package:provider/provider.dart';

import '../cartas/cartas_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenProvider()..initImages(),
      builder: (_, __) => const HomeScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    var provider = Provider.of<HomeScreenProvider>(context);
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/img/landscape.jpg',
                            ))),
                    child: const Center(
                        child: Text(
                      '13 . 07 . 2023',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    )),
                  )),
            ),
            ListTile(
              leading: const Icon(
                HeroIcons.envelope,
                color: secondaryColor,
              ),
              title: const Text('cartas',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'visby')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const CartasScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(
                HeroIcons.heart,
                color: secondaryColor,
              ),
              title: const Text('recuerdos',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'visby')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const RecuerdosScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(
                HeroIcons.users,
                color: secondaryColor,
              ),
              title: const Text('cosas por hacer',
                  style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'visby')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const CartasScreen();
                }));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //icon de menu
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                HeroIcons.bars_3_bottom_left,
                color: primaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('buenos días, usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                //cita del día
                '“La vida es como una caja de chocolates, nunca sabes lo que te va a tocar”',
                style: TextStyle(
                  fontSize: 12,
                  //oblique
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const RecuerdosScreen();
                  }));
                },
                child: const TituloWidget(
                  titulo: 'recuerdos',
                  opcion: 'ver todos',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width,
                height: 250,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      child: Transform(
                        transform: Matrix4.rotationZ(-0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                  milliseconds:
                                      500), // Adjust the fade duration as needed
                              child: Image.network(
                                provider.currentImageLink3,
                                key: ValueKey<String>(provider
                                    .currentImageLink3), // Use a ValueKey to identify different images
                                fit: BoxFit.cover,
                                width: size.width * 0.35,
                                height: 200,
                              ),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      right: 0,
                      child: Transform(
                        transform: Matrix4.rotationZ(0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                  milliseconds:
                                      500), // Adjust the fade duration as needed
                              child: Image.network(
                                provider.currentImageLink2,
                                key: ValueKey<String>(provider
                                    .currentImageLink2), // Use a ValueKey to identify different images
                                fit: BoxFit.cover,
                                width: size.width * 0.35,
                                height: 200,
                              ),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AnimatedSwitcher(
                            duration: const Duration(
                                milliseconds:
                                    500), // Adjust the fade duration as needed
                            child: Image.network(
                              provider.currentImageLink1,
                              key: ValueKey<String>(provider
                                  .currentImageLink1), // Use a ValueKey to identify different images
                              fit: BoxFit.cover,
                              width: size.width * 0.35,
                              height: 200,
                            ),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const CartasScreen();
                  }));
                },
                child: const TituloWidget(
                  titulo: 'últimas cartas',
                  opcion: 'mis cartas',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
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
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  //get index
                  // final data = snapshot.data;

                  // Los datos fueron obtenidos correctamente

                  //get length
                  final length = snapshot.data!.docs.length;

                  //show the last 2 letters
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: length > 1 ? 2 : 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) {
                                return const LeerCarta();
                              },
                              settings: RouteSettings(
                                  arguments: Carta.fromDocumentSnapshot(
                                      snapshot.data!.docs[index]))));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: WidgetCarta(
                            carta: Carta.fromDocumentSnapshot(
                                snapshot.data!.docs[index]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: const TituloWidget(
                  titulo: 'cosas por hacer',
                  opcion: 'ver todas',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(.06),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class WidgetCarta extends StatelessWidget {
  const WidgetCarta({
    super.key,
    required this.carta,
  });
  final Carta carta;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ListTile(
          leading: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              HeroIcons.bookmark,
              color: pinkColor,
            ),
          ),
          title: Text(
            '${carta.title}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: primaryColor,
            ),
          ),
          subtitle: Text(
            formatDate(carta.date!),
            style: const TextStyle(
                fontSize: 12, color: pinkColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

formatDate(Timestamp date) {
  DateTime dateTime = date.toDate();
  return '${dateTime.day} de ${dateTime.month} del ${dateTime.year}';
}

class TituloWidget extends StatelessWidget {
  const TituloWidget({
    super.key,
    this.titulo,
    this.opcion,
  });

  final String? titulo;
  final String? opcion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          titulo!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              opcion!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: secondaryColor,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: secondaryColor,
              size: 18,
            ),
          ],
        ),
      ],
    );
  }
}
