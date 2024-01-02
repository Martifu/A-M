import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jagvault/constants/constants.dart';
import 'package:jagvault/models/letter.dart';
import 'package:jagvault/models/song.dart';
import 'package:jagvault/providers/letters_provider.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/screens/songs/select_song_screen.dart';
import 'package:jagvault/services/letters_service.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:provider/provider.dart';
import 'package:text_editor/text_editor.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateLetter extends StatefulWidget {
  const CreateLetter({Key? key}) : super(key: key);

  @override
  _CreateLetterState createState() => _CreateLetterState();
}

class _CreateLetterState extends State<CreateLetter> {
  List<int> pastelColorsHex = [
    0xFFFFDDC1,
    0xFFFFE2B7,
    0xFFFFF0B7,
    0xFFE4FFB5,
    0xFFB5EAD7,
    0xFFB0E57C,
    0xFFB5EAD7,
    0xFF9AD1D4,
    0xFFA3D9C4,
    0xFFB5D8EB,
    0xFFC7CEEA,
    0xFFFDC4C5,
    0xFFFEC9C7,
    0xFFFFDCD1,
    0xFFFFC7D1,
    0xFFD5A4A2,
    0xFFD5A4A2,
    0xFFE0BBE4,
    0xFFC7C1E0,
    0xFFC4B7CB,
    0xFFF3E1DC,
    0xFFF5CDA7,
    0xFFCDB2AB,
    0xFFF4B8C3,
    0xFFF1B2C7,
    0xFFE2B1C2,
    0xFFCE93D8,
    0xFFC9B2E4,
    0xFFB5AED4,
    0xFFB2DFDB,
    0xFFFFE0B2,
    0xFFE1BEE7,
    0xFFFFCCBC,
    0xFFFFF59D,
    0xFFC8E6C9,
    0xFFBBDEFB,
    0xFFFFD180,
    0xFFE6EE9C,
    0xFFC5E1A5,
    0xFFFFAB91,
    0xFF80CBC4,
    0xFFCE93D8,
    0xFFFFFFFF, // Blanco
    0xFF000000, // Negro suave
  ];

  List<Color>? generateVariations(Color baseColor) {
    return [
      baseColor,
      Color.lerp(baseColor, Colors.white, 0.5)!, // Variación más clara
      Color.lerp(baseColor, Colors.black, 0.5)!, // Variación más oscura
    ];
  }

  void _tapHandler(text, textStyle, textAlign, {bool? isTitle}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(
        milliseconds: 400,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          color: kBackgroundColor.withOpacity(.7),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              // top: false,
              child: TextEditor(
                fonts: context.read<LettersProvider>().fonts,
                text: text,
                textStyle: textStyle,
                textAlingment: textAlign,
                minFontSize: 10,
                paletteColors:
                    pastelColorsHex.map((int color) => Color(color)).toList(),
                decoration: EditorDecoration(
                    textBackground: TextBackgroundDecoration(
                      disable: const SizedBox(),
                      enable: const SizedBox(),
                    ),
                    doneButton: const Text("Listo")),
                onEditCompleted: (style, align, text) {
                  if (isTitle!) {
                    context
                        .read<LettersProvider>()
                        .setTitleStyle(style, text, align);
                  } else {
                    context
                        .read<LettersProvider>()
                        .setTextStyle(style, text, align);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPicker(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Iconsax.camera),
                  title: const Text('Cámara'),
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 50);
                    Provider.of<LettersProvider>(context, listen: false)
                        .setImage(image!);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.image),
                  title: const Text('Galería'),
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    Provider.of<LettersProvider>(context, listen: false)
                        .setImage(image!);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var letterProvider = Provider.of<LettersProvider>(context);
    var size = MediaQuery.of(context).size;
    return PieCanvas(
      theme: const PieTheme(
        delayDuration: Duration.zero,
        overlayColor: Colors.transparent,
        pointerColor: Colors.transparent,
        buttonSize: 40,
        spacing: 10,
        childBounceDistance: 10,

        tooltipTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        customAngle: 220, // In degrees
        customAngleAnchor: PieAnchor.center, // start, center, en
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: letterProvider.backgroundColor,
        body: Hero(
          tag: letterProvider.letter!.id,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: !letterProvider.imageExiste ? kToolbarHeight + 20 : 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        // onTap: () =>
                        //     letterProvider.newLetter ? _showPicker(context) : null,
                        child: Stack(
                          children: [
                            if (letterProvider.image != null ||
                                !letterProvider.newLetter &&
                                    letterProvider.letter!.image != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kBlueChalk,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  height: 300,
                                  child: letterProvider.image != null
                                      ? Image.file(
                                          File(letterProvider.image!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          letterProvider.letter!.image,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            //solo si existe imagen
                            if (letterProvider.image != null ||
                                !letterProvider.newLetter &&
                                    letterProvider.letter!.image != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        letterProvider.backgroundColor,
                                        letterProvider.backgroundColor
                                            .withOpacity(.2),
                                      ],
                                      stops: const [0.0, 0.7],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: size.width,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (letterProvider.newLetter) {
                                    _tapHandler(
                                        letterProvider.title,
                                        letterProvider.titleStyle,
                                        letterProvider.titleAlignment,
                                        isTitle: true);
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    letterProvider.title,
                                    textAlign: letterProvider.titleAlignment,
                                    style: letterProvider.titleStyle,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (letterProvider.newLetter) {
                                    _tapHandler(
                                        letterProvider.text,
                                        letterProvider.textStyle,
                                        letterProvider.textAlignment,
                                        isTitle: false);
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    letterProvider.text,
                                    textAlign: letterProvider.textAlignment,
                                    style: letterProvider.textStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (letterProvider.urlSong != '')
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Color(int.parse(
                                    '0xFF${letterProvider.letter?.songColor}')),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              )
                            ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: [
                                  Image.network(
                                    letterProvider.letter!.songImage!,
                                    width: 50,
                                    height: 50,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  //play pause button
                                  GestureDetector(
                                    onTap: () {
                                      letterProvider.playOrResumeSong();
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        letterProvider.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (letterProvider.newLetter)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    bottom: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextButton(
                                onPressed: () async {
                                  var lettersService =
                                      Provider.of<LettersService>(context,
                                          listen: false);
                                  var userProvider = Provider.of<UserProvider>(
                                      context,
                                      listen: false);

                                  var urlImg = '';
                                  if (letterProvider.image != null) {
                                    urlImg = await lettersService.uploadImage(
                                        File(letterProvider.image!.path));
                                  }

                                  Letter letter = Letter(
                                    id: '',
                                    recipientId: userProvider.user!.uid ==
                                            'BqDM3hlx5OYrOrVJlvw4T2hC3yu2'
                                        ? 'B1t3Aicm6tXN9B9pRjekYTK3Atn1'
                                        : 'BqDM3hlx5OYrOrVJlvw4T2hC3yu2',
                                    senderId: userProvider.user!.uid,
                                    creationDate: DateTime.now(),
                                    timesRead: 0,
                                    image: urlImg,
                                    backgroundColor: letterProvider
                                        .backgroundColor.value
                                        .toRadixString(16)
                                        .substring(2, 8),
                                    title: letterProvider.title,
                                    text: letterProvider.text,
                                    titleColor: letterProvider
                                        .titleStyle.color!.value
                                        .toRadixString(16)
                                        .substring(2, 8),
                                    textColor: letterProvider
                                        .textStyle.color!.value
                                        .toRadixString(16)
                                        .substring(2, 8),
                                    titleSize:
                                        letterProvider.titleStyle.fontSize!,
                                    textSize:
                                        letterProvider.textStyle.fontSize!,
                                    titleFont:
                                        letterProvider.titleStyle.fontFamily!,
                                    textFont:
                                        letterProvider.textStyle.fontFamily!,
                                    songUrl: letterProvider.urlSong,
                                    titleAlignment: letterProvider
                                        .titleAlignment
                                        .toString()
                                        .split('.')
                                        .last,
                                    textAlignment: letterProvider.textAlignment
                                        .toString()
                                        .split('.')
                                        .last,
                                    spotifyUrl:
                                        letterProvider.letter!.spotifyUrl,
                                    youtubeUrl:
                                        letterProvider.letter!.youtubeUrl,
                                    songColor: letterProvider.letter!.songColor,
                                    songImage: letterProvider.letter!.songImage,
                                  );

                                  await lettersService
                                      .createLetter(letter)
                                      .then((value) {
                                    letterProvider.audioPlayer.stop();
                                    Navigator.pop(context);
                                  });
                                },
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    overlayColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ))),
                                child: const Icon(Iconsax.send_1,
                                    color: kBackgroundColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ), //back button
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor:
                                MaterialStateProperty.all(kSecondaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ))),
                        child: const Icon(Icons.arrow_back_ios_rounded,
                            color: kBackgroundColor)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SafeArea(
                    child: PieMenu(
                      actions: [
                        if (!letterProvider.newLetter)
                          PieAction(
                            tooltip: const Text(''),
                            onSelect: () {
                              //launch url
                              if (letterProvider.letter!.spotifyUrl != '') {
                                launchUrl(Uri.parse(
                                    letterProvider.letter!.spotifyUrl!));
                              }
                            },
                            buttonTheme: const PieButtonTheme(
                                backgroundColor: Colors.black,
                                iconColor: Colors.white),
                            child: const Icon(
                              Iconsax.spotify,
                              size: 20,
                            ),
                          ),
                        if (!letterProvider.newLetter)
                          PieAction(
                            tooltip: const Text(''),
                            onSelect: () {
                              //launch url
                              if (letterProvider.letter!.youtubeUrl != '') {
                                launchUrl(Uri.parse(
                                    letterProvider.letter!.youtubeUrl!));
                              }
                            },
                            buttonTheme: const PieButtonTheme(
                                backgroundColor: Colors.black,
                                iconColor: Colors.white),
                            child: const Icon(
                              Iconsax.youtube,
                              size: 20,
                            ),
                          ),
                        if (letterProvider.newLetter)
                          PieAction(
                            tooltip: const Text(''),
                            onSelect: () {
                              _showPicker(context);
                            },
                            buttonTheme: const PieButtonTheme(
                                backgroundColor: Colors.black,
                                iconColor: Colors.white),
                            child: const Icon(
                              Iconsax.image,
                              size: 20,
                            ),
                          ),
                        if (letterProvider.newLetter)
                          PieAction(
                            tooltip: const Text(''),
                            onSelect: () async {
                              Song song = await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext bc) {
                                    return const SelectSongScreen();
                                  });

                              letterProvider.setSong(song);
                            },
                            buttonTheme: const PieButtonTheme(
                                backgroundColor: Colors.black,
                                iconColor: Colors.white),
                            child: const Icon(
                              Iconsax.music,
                              size: 20,
                            ),
                          ),
                        if (letterProvider.newLetter)
                          PieAction(
                            tooltip: const Text(''),
                            onSelect: () async {
                              // Wait for the dialog to return color selection result.
                              final Color newColor =
                                  await showColorPickerDialog(
                                // The dialog needs a context, we pass it in.
                                context,
                                // We use the dialogSelectColor, as its starting color.
                                letterProvider.backgroundColor,
                                title: Text('ColorPicker',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                width: 40,
                                height: 40,
                                spacing: 0,
                                runSpacing: 0,
                                borderRadius: 0,
                                wheelDiameter: 165,
                                showColorCode: true,
                                colorCodeHasColor: true,
                                pickersEnabled: <ColorPickerType, bool>{
                                  ColorPickerType.wheel: true,
                                },
                                copyPasteBehavior:
                                    const ColorPickerCopyPasteBehavior(
                                  copyButton: false,
                                  pasteButton: false,
                                  longPressMenu: false,
                                ),
                                actionButtons: const ColorPickerActionButtons(
                                  okButton: true,
                                  closeButton: true,
                                  dialogActionButtons: false,
                                ),
                                constraints: const BoxConstraints(
                                    minHeight: 480,
                                    minWidth: 320,
                                    maxWidth: 320),
                              );
                              letterProvider.setBackgroundColor(newColor);
                            },
                            buttonTheme: const PieButtonTheme(
                                backgroundColor: Colors.black,
                                iconColor: Colors.white),
                            child: const Icon(
                              Icons.palette,
                              size: 20,
                            ),
                          ),
                      ],
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child:
                            const Icon(Iconsax.menu, color: kBackgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
