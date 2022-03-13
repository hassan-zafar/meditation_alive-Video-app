import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meditation_alive/database/local_database.dart';
import 'package:meditation_alive/models/users.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_test.mocks.dart';

@GenerateMocks([
  UserLocalData,
  AppUserModel
], customMocks: [
  MockSpec<UserLocalData>(as: #MockCatRelaxed, returnNullOnMissingStub: true),
  MockSpec<AppUserModel>(as: #MockUserRelaxed, returnNullOnMissingStub: true),
])
void main() {
  late MockUserLocalData localData;
  late MockAppUserModel user;

  setUp(() {
    localData = MockUserLocalData();
    user = MockAppUserModel();
  });
  test(
    'lets start initializing',
    () {
      when(user.email).thenReturn("asd");
      expect(user.email, "asd");
    },
  );
  test(
    'lets start testing',
    () {
      when(localData.getIsAdmin()).thenReturn(false);
      expect(localData.getIsAdmin(), false);
    },
  );
}
