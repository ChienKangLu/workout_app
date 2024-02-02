import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/port/google_sign_in_port.dart';

import '../mock/google_sign_in.mocks.dart';
import '../mock/google_sign_in_account.mocks.dart';

void main() {
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockMockGoogleSignInAccount;
  late GoogleSignInPort tested;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockMockGoogleSignInAccount = MockGoogleSignInAccount();

    GoogleSignInPort.setUpGoogleSignInInstance(mockGoogleSignIn);

    tested = GoogleSignInPort();
  });

  test('Get instance', () {
    // THEN
    expect(GoogleSignInPort.instance, isNotNull);
  });

  test('Sign in successfully', () async {
    // GIVEN
    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockMockGoogleSignInAccount);

    // THEN
    final result = await tested.signIn();

    // WHEN
    expect(result, true);
  });

  test('Sign in failed', () async {
    // GIVEN
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

    // THEN
    final result = await tested.signIn();

    // WHEN
    expect(result, false);
  });

  test('Sign in error', () async {
    // GIVEN
    when(mockGoogleSignIn.signIn()).thenThrow(Exception());

    // THEN
    final result = await tested.signIn();

    // WHEN
    expect(result, false);
  });

  test('Sign out successfully', () async {
    // GIVEN
    when(mockGoogleSignIn.signOut()).thenAnswer((_) async => null);

    // THEN
    final result = await tested.signOut();

    // WHEN
    expect(result, true);
  });

  test('Sign out failed', () async {
    // GIVEN
    when(mockGoogleSignIn.signOut())
        .thenAnswer((_) async => mockMockGoogleSignInAccount);

    // THEN
    final result = await tested.signOut();

    // WHEN
    expect(result, false);
  });

  test('Sign out error', () async {
    // GIVEN
    when(mockGoogleSignIn.signOut()).thenThrow(Exception());

    // THEN
    final result = await tested.signOut();

    // WHEN
    expect(result, false);
  });
}
