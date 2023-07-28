import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    // var provider = Provider.of<HomeScreenProvider>(context);
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
              title: Text('cartas', style: GoogleFonts.manjari()),
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
              title: Text('recuerdos', style: GoogleFonts.manjari()),
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
              title: Text('cosas por hacer', style: GoogleFonts.manjari()),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('buenos días, usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                //cita del día
                '“La vida es como una caja de chocolates, nunca sabes lo que te va a tocar”',
                style: TextStyle(
                  fontSize: 12,
                  //oblique
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
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
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('m&a')
                    .doc('both')
                    .collection('memories')
                    .limit(3)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var url1 = snapshot.data?.docs[0]['url'];
                  var url2 = snapshot.data?.docs[1]['url'];
                  var url3 = snapshot.data?.docs[2]['url'];

                  var title1 = snapshot.data?.docs[0]['title'];
                  var title2 = snapshot.data?.docs[1]['title'];
                  var title3 = snapshot.data?.docs[2]['title'];

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('error'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: -10,
                        child: Transform(
                          transform: Matrix4.rotationZ(-0.1),
                          child: Container(
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(
                                        milliseconds:
                                            500), // Adjust the fade duration as needed
                                    child: Image.network(
                                      url1,
                                      key: ValueKey<String>(
                                          url1), // Use a ValueKey to identify different images
                                      fit: BoxFit.cover,
                                      width: size.width * 0.4,
                                      height: 150,
                                    ),
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  title1,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: -10,
                        child: Transform(
                          transform: Matrix4.rotationZ(0.1),
                          child: Container(
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(
                                        milliseconds:
                                            500), // Adjust the fade duration as needed
                                    child: Image.network(
                                      url2,
                                      key: ValueKey<String>(
                                          url2), // Use a ValueKey to identify different images
                                      fit: BoxFit.cover,
                                      width: size.width * 0.4,
                                      height: 150,
                                    ),
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  title2,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Container(
                            width: size.width * 0.5,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(
                                        milliseconds:
                                            500), // Adjust the fade duration as needed
                                    child: Image.network(
                                      url3,
                                      key: ValueKey<String>(
                                          url3), // Use a ValueKey to identify different images
                                      fit: BoxFit.cover,
                                      width: size.width * 0.45,
                                      height: size.height * 0.21,
                                    ),
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    title3,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {},
                child: const TituloWidget(
                  titulo: 'cosas por hacer',
                  opcion: 'ver todas',
                ),
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
          leading: Image.asset(
            'assets/img/carta-icon.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
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
  return "${dateTime.day.toString()} de ${meses[dateTime.month - 1]} del ${dateTime.year.toString()}";
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
