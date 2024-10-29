import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/view/Test.dart';
import 'package:recipe/view_model/cubits/login_cubit/login_cubit.dart';

import '../view_model/data/local/shared_helper.dart';
import '../view_model/data/local/shared_keys.dart';
import '../view_model/utils/app_colors.dart';
import '../view_model/utils/navigation.dart';
import '../view_model/utils/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
          () {
        if (SharedHelper.getData(SharedKeys.token) != null) {
          Navigation.pushAndRemove(context, const Test());
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: LoginCubit.get(context).formKey,
          child: ListView(
            padding: EdgeInsets.all(12.sp),
            children: [
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'login',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              TextFormField(
                controller: LoginCubit.get(context).nameController,
                decoration: const InputDecoration(
                  labelText: 'name',
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'LocaleKeys.emailError.tr()';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                controller: LoginCubit.get(context).firstNameController,
                decoration: const InputDecoration(
                  labelText: 'first',
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'LocaleKeys.first.tr()';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                controller: LoginCubit.get(context).lastNameController,
                decoration: const InputDecoration(
                  labelText: 'last name',
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'LocaleKeys.last.tr()';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                controller: LoginCubit.get(context).emailController,
                decoration: const InputDecoration(
                  labelText: 'LocaleKeys.email.tr()',
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return' LocaleKeys.passwordError.tr()';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),

              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    SnackBarHelper.showMessage(context, 'Login Successfully');
                    Navigation.pushAndRemove(context, const Test());
                  } else if (state is LoginErrorState) {
                    SnackBarHelper.showError(context, state.msg);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan
                    ),
                    onPressed: () {
                      if (LoginCubit.get(context)
                          .formKey
                          .currentState!
                          .validate()) {
                        LoginCubit.get(context).login();
                      }
                    },
                    child: Text(
                      'LocaleKeys.login.tr()',
                      style: TextStyle(fontSize: 16.sp, color: AppColors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
