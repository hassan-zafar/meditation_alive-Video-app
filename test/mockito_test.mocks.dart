// Mocks generated by Mockito 5.1.0 from annotations
// in meditation_alive/test/mockito_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:get_storage/get_storage.dart' as _i2;
import 'package:meditation_alive/database/local_database.dart' as _i3;
import 'package:meditation_alive/models/users.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetStorage_0 extends _i1.Fake implements _i2.GetStorage {}

/// A class which mocks [UserLocalData].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserLocalData extends _i1.Mock implements _i3.UserLocalData {
  MockUserLocalData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get s =>
      (super.noSuchMethod(Invocation.getter(#s), returnValue: '') as String);
  @override
  set s(String? _s) => super
      .noSuchMethod(Invocation.setter(#s, _s), returnValueForMissingStub: null);
  @override
  _i2.GetStorage get getStorageProference =>
      (super.noSuchMethod(Invocation.getter(#getStorageProference),
          returnValue: _FakeGetStorage_0()) as _i2.GetStorage);
  @override
  _i4.Future<dynamic> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> set1stOpen() =>
      (super.noSuchMethod(Invocation.method(#set1stOpen, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setNotification(bool? notificationSet) => (super
      .noSuchMethod(Invocation.method(#setNotification, [notificationSet]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setIsAutoPlay(bool? isAutoPlay) =>
      (super.noSuchMethod(Invocation.method(#setIsAutoPlay, [isAutoPlay]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserModel(String? userModel) =>
      (super.noSuchMethod(Invocation.method(#setUserModel, [userModel]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserEmail(String? email) =>
      (super.noSuchMethod(Invocation.method(#setUserEmail, [email]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setname(String? name) =>
      (super.noSuchMethod(Invocation.method(#setname, [name]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#setToken, [token]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setClasses(String? classes) =>
      (super.noSuchMethod(Invocation.method(#setClasses, [classes]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setIsAdmin(bool? isAdmin) =>
      (super.noSuchMethod(Invocation.method(#setIsAdmin, [isAdmin]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserUID(String? uid) =>
      (super.noSuchMethod(Invocation.method(#setUserUID, [uid]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setNotLoggedIn() =>
      (super.noSuchMethod(Invocation.method(#setNotLoggedIn, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setLoggedIn(bool? isLoggedIn) =>
      (super.noSuchMethod(Invocation.method(#setLoggedIn, [isLoggedIn]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  String getUserData() =>
      (super.noSuchMethod(Invocation.method(#getUserData, []), returnValue: '')
          as String);
  @override
  String getBranches() =>
      (super.noSuchMethod(Invocation.method(#getBranches, []), returnValue: '')
          as String);
  @override
  String getClasses() =>
      (super.noSuchMethod(Invocation.method(#getClasses, []), returnValue: '')
          as String);
  @override
  String getUserUIDGet() => (super
          .noSuchMethod(Invocation.method(#getUserUIDGet, []), returnValue: '')
      as String);
  @override
  String getUserEmail() =>
      (super.noSuchMethod(Invocation.method(#getUserEmail, []), returnValue: '')
          as String);
  @override
  String getname() =>
      (super.noSuchMethod(Invocation.method(#getname, []), returnValue: '')
          as String);
  @override
  void storeAppUserData({_i5.AppUserModel? appUser, String? token = r''}) =>
      super.noSuchMethod(
          Invocation.method(
              #storeAppUserData, [], {#appUser: appUser, #token: token}),
          returnValueForMissingStub: null);
}

/// A class which mocks [AppUserModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppUserModel extends _i1.Mock implements _i5.AppUserModel {
  MockAppUserModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, dynamic> toMap() =>
      (super.noSuchMethod(Invocation.method(#toMap, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []), returnValue: '')
          as String);
}

/// A class which mocks [UserLocalData].
///
/// See the documentation for Mockito's code generation for more information.
class MockCatRelaxed extends _i1.Mock implements _i3.UserLocalData {
  @override
  String get s =>
      (super.noSuchMethod(Invocation.getter(#s), returnValue: '') as String);
  @override
  set s(String? _s) => super
      .noSuchMethod(Invocation.setter(#s, _s), returnValueForMissingStub: null);
  @override
  _i2.GetStorage get getStorageProference =>
      (super.noSuchMethod(Invocation.getter(#getStorageProference),
          returnValue: _FakeGetStorage_0()) as _i2.GetStorage);
  @override
  _i4.Future<dynamic> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> set1stOpen() =>
      (super.noSuchMethod(Invocation.method(#set1stOpen, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setNotification(bool? notificationSet) => (super
      .noSuchMethod(Invocation.method(#setNotification, [notificationSet]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setIsAutoPlay(bool? isAutoPlay) =>
      (super.noSuchMethod(Invocation.method(#setIsAutoPlay, [isAutoPlay]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserModel(String? userModel) =>
      (super.noSuchMethod(Invocation.method(#setUserModel, [userModel]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserEmail(String? email) =>
      (super.noSuchMethod(Invocation.method(#setUserEmail, [email]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setname(String? name) =>
      (super.noSuchMethod(Invocation.method(#setname, [name]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#setToken, [token]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setClasses(String? classes) =>
      (super.noSuchMethod(Invocation.method(#setClasses, [classes]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setIsAdmin(bool? isAdmin) =>
      (super.noSuchMethod(Invocation.method(#setIsAdmin, [isAdmin]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setUserUID(String? uid) =>
      (super.noSuchMethod(Invocation.method(#setUserUID, [uid]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setNotLoggedIn() =>
      (super.noSuchMethod(Invocation.method(#setNotLoggedIn, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> setLoggedIn(bool? isLoggedIn) =>
      (super.noSuchMethod(Invocation.method(#setLoggedIn, [isLoggedIn]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  String getUserData() =>
      (super.noSuchMethod(Invocation.method(#getUserData, []), returnValue: '')
          as String);
  @override
  String getBranches() =>
      (super.noSuchMethod(Invocation.method(#getBranches, []), returnValue: '')
          as String);
  @override
  String getClasses() =>
      (super.noSuchMethod(Invocation.method(#getClasses, []), returnValue: '')
          as String);
  @override
  String getUserUIDGet() => (super
          .noSuchMethod(Invocation.method(#getUserUIDGet, []), returnValue: '')
      as String);
  @override
  String getUserEmail() =>
      (super.noSuchMethod(Invocation.method(#getUserEmail, []), returnValue: '')
          as String);
  @override
  String getname() =>
      (super.noSuchMethod(Invocation.method(#getname, []), returnValue: '')
          as String);
  @override
  void storeAppUserData({_i5.AppUserModel? appUser, String? token = r''}) =>
      super.noSuchMethod(
          Invocation.method(
              #storeAppUserData, [], {#appUser: appUser, #token: token}),
          returnValueForMissingStub: null);
}

/// A class which mocks [AppUserModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRelaxed extends _i1.Mock implements _i5.AppUserModel {
  @override
  Map<String, dynamic> toMap() =>
      (super.noSuchMethod(Invocation.method(#toMap, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []), returnValue: '')
          as String);
}
