import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'form_field_validator.dart';
import 'register_cubit.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterCubit cubit = RegisterCubit();
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Creating a new account',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        debugPrint('=======> form key: ${_formKey.currentState?.validate()}');
                        cubit.setRegisterBtnEnabled(
                          _formKey.currentState?.validate() ?? false,
                        );
                      },
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Name is required'),
                          MinLengthValidator(
                            3,
                            errorText:
                                'Name must have at least 3 characters long',
                          ),
                        ],
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintMaxLines: 1,
                        hintStyle: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        'Choose your gender',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          child: Text('Male'),
                          value: 'male',
                        ),
                        DropdownMenuItem(
                          child: Text('Female'),
                          value: 'female',
                        ),
                      ],
                      onChanged: (value) {
                        debugPrint('======> selected drop down item: $value');
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width - 72, 60),
                        padding: const EdgeInsets.all(12),
                      ),
                      onPressed: state.isRegisterBtnEnabled ? () {} : null,
                      child: Text(
                        'Register',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
