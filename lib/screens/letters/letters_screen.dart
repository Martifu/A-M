import 'package:flutter/material.dart';
import 'package:jagvault/constants/constants.dart';
import 'package:jagvault/models/letter.dart';
import 'package:jagvault/providers/letters_provider.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/services/auth_service.dart';
import 'package:jagvault/services/letters_service.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lettersProvider = Provider.of<LettersProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Mis\nCartas 📝",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ])),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            lettersProvider.letterType = LetterType.received;
                          },
                          style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStateProperty.all(kBlueChalk),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ))),
                          child: Text(
                            "Recibidas",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: lettersProvider.letterType ==
                                        LetterType.received
                                    ? kPrimaryColor
                                    : Colors.grey[400]),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            lettersProvider.letterType = LetterType.sent;
                          },
                          style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStateProperty.all(kBlueChalk),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ))),
                          child: Text(
                            "Enviadas",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: lettersProvider.letterType ==
                                        LetterType.sent
                                    ? kPrimaryColor
                                    : Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                  ])),
                  //slivergrid
                  StreamBuilder(
                    stream: lettersProvider.letterType == LetterType.received
                        ? context
                            .read<LettersService>()
                            .receivedLetters(userProvider.user!.uid)
                        : context
                            .read<LettersService>()
                            .sentLetters(userProvider.user!.uid),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 4.0 / 4.5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Letter letter = snapshot.data[index];
                            return Hero(
                              tag: letter.id,
                              child: _LetterCard(letter: letter),
                            );
                          },
                          childCount: snapshot.data?.length ?? 0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + 35,
              ),
              child: ElevatedButton(
                onPressed: () {
                  lettersProvider.setLetterEdit(null);
                  Navigator.of(context).pushNamed('/create_letter');
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side: const BorderSide(color: kBlueChalk),
                    ))),
                child: const Text(
                  "Nueva carta +",
                  style: TextStyle(color: kBlueChalk),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LetterCard extends StatelessWidget {
  const _LetterCard({
    required this.letter,
  });

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    var lettersProvider = Provider.of<LettersProvider>(context);
    return GestureDetector(
      onTap: () {
        lettersProvider.setLetterEdit(letter);
        Navigator.of(context)
            .pushNamed('/create_letter')
            .then((value) => lettersProvider.audioPlayer.stop());
      },
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Color(int.parse('0xff${letter.backgroundColor}')),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (letter.image != '')
                AspectRatio(
                  aspectRatio: 4.0 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        letter.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (letter.image == '')
                AspectRatio(
                    aspectRatio: 4.0 / 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          letter.songImage!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Text(
                  letter.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(int.parse('0xff${letter.titleColor}')),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
