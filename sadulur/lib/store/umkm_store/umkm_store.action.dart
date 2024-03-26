import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';

class UmkmStoreAction {
  @override
  String toString() {
    return 'UmkmStoreAction { }';
  }
}

class GetAllUmkmStoreAction {
  final String type = "GET_ALL_UMKM_STORE";
  GetAllUmkmStoreAction();

  @override
  String toString() {
    return 'GetAllUmkmStoreAction { }';
  }
}

class GetUmkmStoreDetailAction {
  final String id;
  final String type = "GET_UMKM_STORE_DETAIL_ACTION";
  GetUmkmStoreDetailAction({required this.id});

  @override
  String toString() {
    return 'GetUmkmStoreDetailAction { id: $id }';
  }
}

class GetUmkmStoreDetailSuccessAction {
  final dynamic payload;
  final String type = "GET_UMKM_STORE_DETAIL_SUCCESS";
  GetUmkmStoreDetailSuccessAction({required this.payload});

  @override
  String toString() {
    return 'GetUmkmStoreDetailSuccessAction { payload: $payload }';
  }
}

class GetAllUmkmStoreSuccessAction {
  final String type = "GET_ALL_UMKM_STORE_SUCCESS";
  final dynamic payload;

  GetAllUmkmStoreSuccessAction({required this.payload});
  @override
  String toString() {
    return 'GetAllUmkmStoreSuccessAction { payload: $payload }';
  }
}

class GetAllStoreProductsAction {
  final String type = "GET_ALL_STORE_PRODUCT_ACTION";
  final String id;

  GetAllStoreProductsAction({required this.id});

  @override
  String toString() {
    return 'GetAllStoreProductsAction { id: $id }';
  }
}

class GetAllStoreProdcutsSuccessAction {
  final String type = "GET_ALL_STORE_PRODUCT_SUCCESS_ACTION";
  final dynamic payload;

  GetAllStoreProdcutsSuccessAction({required this.payload});
}

class UmkmStoreFailedAction {
  final String type = "UMKM_STORE_FAILED";
  final String error;

  UmkmStoreFailedAction({required this.error});

  @override
  String toString() {
    return 'UmkmStoreFailedAction { error: $error }';
  }
}

class UpdateUMKMStoreInfoAction {
  final String type = "UPDATE_UMKM_STORE_INFO";
  final dynamic request;
  final BuildContext context;
  final UMKMUser? user;
  final UMKMStore store;

  UpdateUMKMStoreInfoAction(
      {required this.request,
      required this.context,
      this.user,
      required this.store});
}

class UpdateUMKMStoreInfoSuccessAction {
  final String type = "UPDATE_UMKM_STORE_INFO";
  final UMKMUser user;
  UpdateUMKMStoreInfoSuccessAction({required this.user});
}

class UpdateUMKMPictureAction {
  final String type = "UPDATE_UMKM_PICTURE_ACTION";
  final File file;
  final BuildContext context;
  final String userID;
  final UMKMStore store;

  UpdateUMKMPictureAction(
      {required this.file,
      required this.context,
      required this.userID,
      required this.store});
}

class UpdateUMKMPictureSuccessAction {
  final String type = "UPDATE_UMKM_PICTURE_SUCCESS";
  final UMKMStore store;

  UpdateUMKMPictureSuccessAction({required this.store});
}
