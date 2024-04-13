import 'dart:io';
import 'package:barbearia_dos_brabos/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:barbearia_dos_brabos/service/authentication_service.dart';
import 'package:image_picker/image_picker.dart';

class Menu extends StatefulWidget {
  Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  final ImagePicker _picker = ImagePicker();

  bool _isExpanded = false;

  void logOut(BuildContext context) {
    _authenticationService.logOut();
    Navigator.pop(context);
  }

  void expandHeaderOptions() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void updatePhoto({String? url = null}) async {
    await _authenticationService.updateUserPhoto(url!);
  }

  void getImageFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      updatePhoto(url: pickedFile.path);
    }
  }

  void removePhoto() {
    updatePhoto(url: 'assets/image/person_placeholder.png');
  }

  void about() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(color: MyColors.secondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: MyColors.secondary,
                        builder: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: getImageFromGallery,
                                icon: Icon(Icons.image_outlined,
                                    color: MyColors.grey),
                                label: Text(
                                  'Alterar',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: removePhoto,
                                icon: Icon(
                                  Icons.highlight_remove_sharp,
                                  color: MyColors.grey,
                                ),
                                label: Text(
                                  'Remover',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        context: context,
                        constraints: BoxConstraints(
                          maxHeight: 120,
                          minWidth: double.infinity,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 4, color: MyColors.greyText),
                        image: _firebaseAuth.currentUser!.photoURL != null &&
                                _firebaseAuth
                                    .currentUser!.photoURL!.isNotEmpty &&
                                File(_firebaseAuth.currentUser!.photoURL!)
                                    .existsSync()
                            ? DecorationImage(
                                image: FileImage(
                                  File(_firebaseAuth.currentUser!.photoURL!),
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage(
                                    'assets/image/person_placeholder.png'),
                              ),
                      ),
                      margin: EdgeInsets.only(
                        left: 15,
                      ),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      _firebaseAuth.currentUser!.displayName!,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ExpansionTile(
                childrenPadding: const EdgeInsets.only(left: 25),
                title: Text(
                  _firebaseAuth.currentUser!.email!,
                ),
                children: [
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text(
                      'Histórico',
                      style: TextStyle(fontSize: 10),
                    ),
                    onTap: () {
                      // Implementar a lógica para exibir o histórico
                    },
                    dense: true,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Perfil',
                      style: TextStyle(fontSize: 10),
                    ),
                    onTap: () {
                      // Implementar a lógica para exibir o perfil
                    },
                    dense: true,
                  ),
                ],
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.people_alt_sharp),
          title: const Text('Barbeiros'),
          onTap: () {}, // visualizar barbeiros e suas habilidades
          dense: true,
        ),
        ListTile(
          leading: const Icon(Icons.cut_sharp),
          title: const Text('Serviços'),
          onTap: () {},
          dense: true,
        ),
        ListTile(
          leading: const Icon(Icons.menu_book_sharp),
          title: const Text('Sobre'),
          onTap: about,
          dense: true,
        ),
        Divider(
          color: MyColors.darkText,
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: const Text('Sair'),
          onTap: () => logOut(context),
        ),
        // ListBody(
        //   children: [
        //     TextButton(
        //       onPressed: () {},
        //       child: Text('Sobre'),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
