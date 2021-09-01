import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';

import 'package:newshop/Cubits/Cubit/cubit_state.dart';
import 'package:newshop/Cubits/CubitRegister/cubit_bottom_register/cubit_screen_register.dart';
import 'package:newshop/Cubits/CubitRegister/cubit_bottom_register/states_register.dart';

import 'package:newshop/Network/shearedpref/shared.dart';
import 'package:newshop/screens/layout_screens/shop_layout1.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textNameControl = TextEditingController();
  var textEmailControl = TextEditingController();
  var textPasswordControl = TextEditingController();
  var textPhoneControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitShopRegister(),
        child: BlocConsumer<CubitShopRegister, CubitShopStateRegister>(
          listener: (context, state) {
            if (state is CubitStatePostDataSuccessRegister) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);

                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data.token)
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopLayout1()),
                      (route) => false);
                });
              } else {
                showToast(
                    massage: state.loginModel.message,
                    state: lockToastStats.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                                "Don't Forget your Name , Email ,Password And Phone ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'name Must Not Empty';
                                }
                                return null;
                              },
                              controller: textNameControl,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefix: Icon(Icons.person),
                                  labelText: 'Name'),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email Must Not Empty';
                                }
                                return null;
                              },
                              controller: textEmailControl,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefix: Icon(Icons.email_outlined),
                                  labelText: 'Email Address'),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                                controlText: textPasswordControl,
                                isPassword:
                                    CubitShopRegister.get(context).isPassword,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {
                                    CubitShopRegister.get(context).userLogin(
                                      name: textNameControl.text,
                                      email: textEmailControl.text,
                                      password: textPasswordControl.text,
                                      phone: textPhoneControl.text,
                                    );
                                  }
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Password Must Not Empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                suffix: CubitShopRegister.get(context).suffix,
                                suffixPressed: () {
                                  CubitShopRegister.get(context)
                                      .changeSeeVisibilityPassword();
                                },
                                textLabel: 'Password'),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone Must Not Empty';
                                }
                                return null;
                              },
                              controller: textPhoneControl,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefix: Icon(Icons.phone),
                                  labelText: 'Phone'),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! CubitStatePostDataLoading,
                              builder: (context) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      CubitShopRegister.get(context).userLogin(
                                        name: textNameControl.text,
                                        email: textEmailControl.text,
                                        password: textPasswordControl.text,
                                        phone: textPhoneControl.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Don't have Email ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()));
                                    },
                                    child: Text('Register'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue)))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
