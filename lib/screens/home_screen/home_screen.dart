import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jagvault/constants.dart';
import 'package:jagvault/constants/constants.dart';
import 'package:jagvault/models/carta.dart';
import 'package:jagvault/models/letter.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/screens/recuerdos/recuerdos_screen.dart';
import 'package:jagvault/services/letters_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    var userProvider = Provider.of<UserProvider>(context);
    var firestoreService = Provider.of<LettersService>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('buenos días ${userProvider.userData?.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    )),
              ),
              const SizedBox(
                height: 10,
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
              // SizedBox(
              //     width: size.width,
              //     height: size.height * 0.3,
              //     child: StreamBuilder(
              //       stream: firestoreService.receivedLetters(),
              //       builder: (BuildContext context,
              //           AsyncSnapshot<List<Letter>> snapshot) {
              //         if (snapshot.hasError) {
              //           return Text('Error: ${snapshot.error}');
              //         }
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return const CircularProgressIndicator();
              //         }
              //         return ListView(
              //           children: snapshot.data!.map((Letter letter) {
              //             return ListTile(
              //               title: Text(
              //                 letter.title,
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w900,
              //                   color: Color(
              //                       int.parse('0xff${letter.titleColor}')),
              //                 ),
              //               ),
              //               subtitle: Text(letter.text),
              //               // Más propiedades...
              //             );
              //           }).toList(),
              //         );
              //       },
              //     )),
              const SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //         return const CartasScreen();
              //       }));
              //     },
              //     child: const TituloWidget(
              //       titulo: 'últimas cartas',
              //       opcion: 'mis cartas',
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('m&a')
              //         .doc('martin')
              //         .collection('letters')
              //         .orderBy('date', descending: true)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return const Text('Error al obtener los datos');
              //       }

              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(child: CupertinoActivityIndicator());
              //       }
              //       //get index
              //       // final data = snapshot.data;

              //       // Los datos fueron obtenidos correctamente

              //       //get length
              //       final length = snapshot.data!.docs.length;

              //       //show the last 2 letters
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: length > 1 ? 2 : 1,
              //         itemBuilder: (context, index) {
              //           return GestureDetector(
              //             onTap: () {
              //               Navigator.of(context).push(MaterialPageRoute(
              //                   builder: (_) {
              //                     return const LeerCarta();
              //                   },
              //                   settings: RouteSettings(
              //                       arguments: Carta.fromDocumentSnapshot(
              //                           snapshot.data!.docs[index]))));
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.only(bottom: 10),
              //               child: WidgetCarta(
              //                 carta: Carta.fromDocumentSnapshot(
              //                     snapshot.data!.docs[index]),
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: const TituloWidget(
              //       titulo: 'cosas por hacer',
              //       opcion: 'ver todas',
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   width: size.width,
              //   height: 100,
              //   decoration: BoxDecoration(
              //     color: secondaryColor.withOpacity(.06),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
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
