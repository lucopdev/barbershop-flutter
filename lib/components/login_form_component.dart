import 'package:barbearia_dos_brabos/_common/custom_snackbar.dart';
import 'package:barbearia_dos_brabos/model/user_model.dart';
import 'package:barbearia_dos_brabos/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:barbearia_dos_brabos/_common/get_input_decoration.dart';
import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:barbearia_dos_brabos/service/authentication_service.dart';
import 'package:uuid/uuid.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationPasswordController = TextEditingController();
  final _observationController = TextEditingController();
  bool _isObscured = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<NavigatorState> _dialogKey = GlobalKey<NavigatorState>();

  final AuthenticationService _authenticationService = AuthenticationService();
  final UserService _userService = UserService();

  bool _singIn = false;

  void getRegistrationScreen() {
    setState(() {
      _singIn = true;
    });
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authenticationService
            .loginUser(
          email: _emailController.text,
          password: _passwordController.text,
        )
            .then((String? error) {
          if (error != null) {
            showCustomSnackBar(
              context: context,
              text: 'Dados inválidos',
              duration: 5,
            );
          } else {
            showCustomSnackBar(
              context: context,
              text: 'Entrou com sucesso!',
              isError: false,
              duration: 5,
            );
          }
        });
      } catch (e) {
        print('Login Error: $e');
      } finally {
        // Navigator.of(context).pop();
      }
    }
  }

  void singIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authenticationService
            .createUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        )
            .then((String? error) async {
          if (error != null) {
            showCustomSnackBar(
                context: context, text: 'Esse e-mail já foi utilizado');
          } else {
            showCustomSnackBar(
              context: context,
              text: 'Entrou com sucesso!',
              isError: false,
              duration: 5,
            );

            String name = _nameController.text;
            String lastName = _lastNameController.text;
            String address = _addressController.text;
            String phone = _phoneController.text;
            String password = _passwordController.text;
            String observation = _observationController.text;

            UserModel user = UserModel(
              id: const Uuid().v1(),
              name: name,
              lastName: lastName,
              address: address,
              phone: phone,
              password: password,
              observation: observation,
              isAdmin: false,
            );

            await _userService.createUserInFirestore(user);
          }
        });
      } catch (e) {
        print('Sing In Error: $e');
      } finally {
        setState(() {
          _singIn = false;
        });
        // Navigator.of(context).pop();
      }
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty || RegExp(r'[0-9]').hasMatch(value)) {
      return 'Nome inválido';
    }

    return null;
  }

  String? validateAddress(String? value) {
    if (value!.isEmpty || !RegExp(r'^.*[a-zA-Z].*$').hasMatch(value)) {
      return 'Endereço inválido';
    }

    return null;
  }

  String? validatePhone(String? value) {
    final RegExp phoneRegex = RegExp(r'^\(\d{2}\)\s\d{5}-\d{4}$');
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      return 'Telefone inválido';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return 'Email inválido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,}$');
    if (!passwordRegex.hasMatch(value!)) {
      return '''
Requisítos:

Mínimo 8 (oito) caracteres
ao menos uma letra maiúscula
ao menos um número
ao menos um caractere especial''';
    }

    return null;
  }

  String? validateConfirmationPassword(String? value) {
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,}$');
    final bool equalPass =
        _passwordController.text == _confirmationPasswordController.text;

    if (!passwordRegex.hasMatch(value!) || !equalPass) {
      return 'Senha inválida';
    }

    return null;
  }

  void backToLogin() {
    setState(() {
      _singIn = false;
    });
  }

  void changePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double logoAssetHeight = 200;
    Widget logoAsset = Image.asset(
      'assets/image/logo.png',
      width: logoAssetHeight,
    );
    var phoneMaskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

    return Container(
      margin: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: logoAsset,
            ),
            Visibility(
              visible: _singIn,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: getInputDecoration('Nome'),
                    validator: validateName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: getInputDecoration('Sobrenome'),
                    validator: validateName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: getInputDecoration('Endereço'),
                    validator: validateAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneMaskFormatter],
                    controller: _phoneController,
                    decoration: getInputDecoration('(00) 00000-0000'),
                    validator: validatePhone,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: getInputDecoration('E-mail'),
              validator: validateEmail,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                controller: _passwordController,
                decoration: getPasswordInputDecoration(
                  'Senha',
                  changePasswordVisibility,
                  _isObscured,
                ),
                obscureText: _isObscured,
                validator: validatePassword,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
                visible: _singIn,
                child: Column(children: [
                  TextFormField(
                    controller: _confirmationPasswordController,
                    decoration: getPasswordInputDecoration(
                      'Confirme a senha',
                      changePasswordVisibility,
                      _isObscured,
                    ),
                    obscureText: _isObscured,
                    validator: validateConfirmationPassword,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLength: 300,
                    maxLines: 5,
                    controller: _observationController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Observações',
                        alignLabelWithHint: true,
                        contentPadding:
                            const EdgeInsets.only(left: 20, top: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: !_singIn,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.lightText,
                          backgroundColor: MyColors.primary,
                          minimumSize: const Size.square(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: login,
                      icon: const Icon(Icons.login),
                      label: const Text('Entrar')),
                ),
                Visibility(
                  visible: !_singIn,
                  child: TextButton(
                    onPressed: getRegistrationScreen,
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(color: MyColors.darkText),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: _singIn,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.lightText,
                          backgroundColor: MyColors.primary,
                          minimumSize: const Size.square(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: singIn,
                      child: const Text('Cadastrar')),
                ),
                Visibility(
                  visible: _singIn,
                  child: TextButton(
                    onPressed: backToLogin,
                    child: const Text('Voltar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
