import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jagvault/constants.dart';
import 'package:jagvault/screens/home_screen/provider.dart';
import 'package:provider/provider.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('martin')
                    .doc('notas')
                    .collection('own')
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
                  print(data!.docs[0]['titulo']);
                  return Text(data.docs[0]['titulo']);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const TituloWidget(
                titulo: 'recuerdos',
                opcion: 'ver todos',
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
              const TituloWidget(
                titulo: 'últimas cartas',
                opcion: 'mis cartas',
              ),
              const SizedBox(
                height: 10,
              ),
              const WidgetCarta(),
              const SizedBox(
                height: 10,
              ),
              const WidgetCarta(),
              const SizedBox(
                height: 20,
              ),
              const TituloWidget(
                titulo: 'cosas por hacer',
                opcion: 'ver todas',
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              HeroIcons.bookmark,
              color: pinkColor,
            ),
          ),
          title: Text(
            'título de la carta',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: primaryColor,
            ),
          ),
          subtitle: Text(
            '12 de Julio de 2023',
            style: TextStyle(fontSize: 12, color: pinkColor),
          ),
        ),
      ),
    );
  }
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
