import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/Component/constants.dart';
import 'package:newshop/Cubits/CubitRegister/cubit_bottom_register/cubit_screen_register.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameControl = TextEditingController();
  var emailControl = TextEditingController();
  var phoneControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShopScreenAll, CubitStatesBottom>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = CubitShopScreenAll.get(context).getProfileSetting;
        nameControl.text = model.data.name;
        emailControl.text = model.data.email;
        phoneControl.text = model.data.phone;

        return ConditionalBuilder(
          condition: CubitShopScreenAll.get(context).getProfileSetting != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpDateState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      controlText: nameControl,
                      prefix: Icons.person,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be Empty';
                        }
                        return null;
                      },
                      textLabel: 'Name',
                      type: TextInputType.name),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controlText: emailControl,
                      prefix: Icons.email,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be Empty';
                        }
                        return null;
                      },
                      textLabel: 'Email',
                      type: TextInputType.emailAddress),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controlText: phoneControl,
                      prefix: Icons.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone must not be Empty';
                        }
                        return null;
                      },
                      textLabel: 'Phone',
                      type: TextInputType.phone),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () => signOut(context),
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          CubitShopScreenAll.get(context).upDateUserData(
                              name: nameControl.text,
                              email: emailControl.text,
                              phone: phoneControl.text);
                        }
                      },
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
