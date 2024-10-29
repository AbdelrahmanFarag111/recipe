import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe/view_model/data/local/shared_helper.dart';
import 'package:recipe/view_model/data/local/shared_keys.dart';
import 'package:recipe/view_model/data/network/dio_helper.dart';
import 'package:recipe/view_model/data/network/end%20pionts.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() async {
    emit(LoginLoadingState());
    await DioHelper.postLogin(
      withToken: true,
      path: EndPoints.login,
      body: {
        'username': nameController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
      },
    ).then(
      (value) {
        SharedHelper.saveData(SharedKeys.userName, value.data['username']);
        SharedHelper.saveData(SharedKeys.email, value.data['email']);
        SharedHelper.saveData(SharedKeys.token, value.data['hash']);
        if (kDebugMode) {
          print(SharedKeys.userName);
        }
        emit(LoginSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        if (kDebugMode) {
          print(error);
        }
        emit(
          LoginErrorState(error.response?.data['message'] ?? 'Error on Login'),
        );
      }
    });
  }
}
