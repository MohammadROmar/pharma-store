// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `User name shoud be at least 2 characters`
  String get nameCheck {
    return Intl.message(
      'User name shoud be at least 2 characters',
      name: 'nameCheck',
      desc: '',
      args: [],
    );
  }

  /// `Please check your phone number.`
  String get phoneValidate {
    return Intl.message(
      'Please check your phone number.',
      name: 'phoneValidate',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password shoud be at least 8 characters`
  String get passwordValidate {
    return Intl.message(
      'Password shoud be at least 8 characters',
      name: 'passwordValidate',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get creat {
    return Intl.message(
      'Create',
      name: 'creat',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get creatAcc {
    return Intl.message(
      'Create Account',
      name: 'creatAcc',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLan {
    return Intl.message(
      'Choose Language',
      name: 'chooseLan',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Plaease check you phone number and password`
  String get wrongInput {
    return Intl.message(
      'Plaease check you phone number and password',
      name: 'wrongInput',
      desc: '',
      args: [],
    );
  }

  /// `Phone number already exists`
  String get exists {
    return Intl.message(
      'Phone number already exists',
      name: 'exists',
      desc: '',
      args: [],
    );
  }

  /// `Cholesterol`
  String get chol {
    return Intl.message(
      'Cholesterol',
      name: 'chol',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get bloodPr {
    return Intl.message(
      'Blood Pressure',
      name: 'bloodPr',
      desc: '',
      args: [],
    );
  }

  /// `Supplements`
  String get foodMed {
    return Intl.message(
      'Supplements',
      name: 'foodMed',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message(
      'Fat',
      name: 'fat',
      desc: '',
      args: [],
    );
  }

  /// `Pain Killer`
  String get painKiller {
    return Intl.message(
      'Pain Killer',
      name: 'painKiller',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found here!`
  String get nothingFound {
    return Intl.message(
      'Nothing found here!',
      name: 'nothingFound',
      desc: '',
      args: [],
    );
  }

  /// `Try selecting a defferent category.`
  String get tryElse {
    return Intl.message(
      'Try selecting a defferent category.',
      name: 'tryElse',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Scientific Name`
  String get scientificName {
    return Intl.message(
      'Scientific Name',
      name: 'scientificName',
      desc: '',
      args: [],
    );
  }

  /// `Commerical Name`
  String get commName {
    return Intl.message(
      'Commerical Name',
      name: 'commName',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Available Amount`
  String get amount {
    return Intl.message(
      'Available Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get theme {
    return Intl.message(
      'Dark theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Per item.`
  String get perItem {
    return Intl.message(
      'Per item.',
      name: 'perItem',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Saved.`
  String get added {
    return Intl.message(
      'Saved.',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Unsaved.`
  String get removed {
    return Intl.message(
      'Unsaved.',
      name: 'removed',
      desc: '',
      args: [],
    );
  }

  /// `Try adding somthing.`
  String get tryAdd {
    return Intl.message(
      'Try adding somthing.',
      name: 'tryAdd',
      desc: '',
      args: [],
    );
  }

  /// `Place an Order.`
  String get order {
    return Intl.message(
      'Place an Order.',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Type somthing to seach for.`
  String get type {
    return Intl.message(
      'Type somthing to seach for.',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get addOrder {
    return Intl.message(
      'Place Order',
      name: 'addOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Order Added`
  String get orderAdded {
    return Intl.message(
      'Order Added',
      name: 'orderAdded',
      desc: '',
      args: [],
    );
  }

  /// `Show details`
  String get showDetails {
    return Intl.message(
      'Show details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Placed`
  String get orderPlaced {
    return Intl.message(
      'Order Placed',
      name: 'orderPlaced',
      desc: '',
      args: [],
    );
  }

  /// `WE have received your order`
  String get orderPlacedDetail {
    return Intl.message(
      'WE have received your order',
      name: 'orderPlacedDetail',
      desc: '',
      args: [],
    );
  }

  /// `Order Confirmed`
  String get orderConfirmed {
    return Intl.message(
      'Order Confirmed',
      name: 'orderConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `We have confirmed your order`
  String get orderConfirmedDetail {
    return Intl.message(
      'We have confirmed your order',
      name: 'orderConfirmedDetail',
      desc: '',
      args: [],
    );
  }

  /// `Order Shipped`
  String get orderShipped {
    return Intl.message(
      'Order Shipped',
      name: 'orderShipped',
      desc: '',
      args: [],
    );
  }

  /// `We have shipped your order`
  String get orderShipedDetail {
    return Intl.message(
      'We have shipped your order',
      name: 'orderShipedDetail',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get orderDelivered {
    return Intl.message(
      'Delivered',
      name: 'orderDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been delivered`
  String get orderDeliveredDetail {
    return Intl.message(
      'Your order has been delivered',
      name: 'orderDeliveredDetail',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Value`
  String get invaild {
    return Intl.message(
      'Invalid Value',
      name: 'invaild',
      desc: '',
      args: [],
    );
  }

  /// `Antibiotics`
  String get antibiotics {
    return Intl.message(
      'Antibiotics',
      name: 'antibiotics',
      desc: '',
      args: [],
    );
  }

  /// `Obesity`
  String get obesity {
    return Intl.message(
      'Obesity',
      name: 'obesity',
      desc: '',
      args: [],
    );
  }

  /// `Antidiabetic`
  String get antidiabetic {
    return Intl.message(
      'Antidiabetic',
      name: 'antidiabetic',
      desc: '',
      args: [],
    );
  }

  /// `Cardiovascular`
  String get cardiovascular {
    return Intl.message(
      'Cardiovascular',
      name: 'cardiovascular',
      desc: '',
      args: [],
    );
  }

  /// `Neurological & Psychlogical`
  String get neurologicalPsychlogical {
    return Intl.message(
      'Neurological & Psychlogical',
      name: 'neurologicalPsychlogical',
      desc: '',
      args: [],
    );
  }

  /// `Nsaids & Analgesics & Antipyretic`
  String get nsaidsAnalgesicsAntipyretic {
    return Intl.message(
      'Nsaids & Analgesics & Antipyretic',
      name: 'nsaidsAnalgesicsAntipyretic',
      desc: '',
      args: [],
    );
  }

  /// `Gastrointestinal`
  String get gastrointestinal {
    return Intl.message(
      'Gastrointestinal',
      name: 'gastrointestinal',
      desc: '',
      args: [],
    );
  }

  /// `Respiratory`
  String get respiratory {
    return Intl.message(
      'Respiratory',
      name: 'respiratory',
      desc: '',
      args: [],
    );
  }

  /// `Musculoskeletal`
  String get musculoskeletal {
    return Intl.message(
      'Musculoskeletal',
      name: 'musculoskeletal',
      desc: '',
      args: [],
    );
  }

  /// `Urological`
  String get urological {
    return Intl.message(
      'Urological',
      name: 'urological',
      desc: '',
      args: [],
    );
  }

  /// `Dermatological`
  String get dermatological {
    return Intl.message(
      'Dermatological',
      name: 'dermatological',
      desc: '',
      args: [],
    );
  }

  /// `Vitamins & Minerals`
  String get vitaminsMinerals {
    return Intl.message(
      'Vitamins & Minerals',
      name: 'vitaminsMinerals',
      desc: '',
      args: [],
    );
  }

  /// `Food & Supplement`
  String get foodSupplement {
    return Intl.message(
      'Food & Supplement',
      name: 'foodSupplement',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get medName {
    return Intl.message(
      'Medicine Name',
      name: 'medName',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `More than the available quantity.`
  String get invaildQuantity {
    return Intl.message(
      'More than the available quantity.',
      name: 'invaildQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Could not find the medicine`
  String get cantFind {
    return Intl.message(
      'Could not find the medicine',
      name: 'cantFind',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get medicines {
    return Intl.message(
      'Medicines',
      name: 'medicines',
      desc: '',
      args: [],
    );
  }

  /// `Try adding some medicines`
  String get tryAdding {
    return Intl.message(
      'Try adding some medicines',
      name: 'tryAdding',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get deleteOrder {
    return Intl.message(
      'Cancel Order',
      name: 'deleteOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you that sure you want to cancel this order?`
  String get deleteOrderContent {
    return Intl.message(
      'Are you that sure you want to cancel this order?',
      name: 'deleteOrderContent',
      desc: '',
      args: [],
    );
  }

  /// `Preparing`
  String get preparing {
    return Intl.message(
      'Preparing',
      name: 'preparing',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Arrived`
  String get arrived {
    return Intl.message(
      'Arrived',
      name: 'arrived',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get cats {
    return Intl.message(
      'Category',
      name: 'cats',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get meds {
    return Intl.message(
      'Medicines',
      name: 'meds',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
