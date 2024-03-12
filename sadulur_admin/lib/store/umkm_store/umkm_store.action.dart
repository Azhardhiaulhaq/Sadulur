
import 'package:flutter/material.dart';

class UmkmStoreAction {

	@override
	String toString() {
	return 'UmkmStoreAction { }';
	}
}

class UmkmStoreSuccessAction {
	final int isSuccess;

	UmkmStoreSuccessAction({required this.isSuccess});
	@override
	String toString() {
	return 'UmkmStoreSuccessAction { isSuccess: $isSuccess }';
	}
}

class UmkmStoreFailedAction {
	final String error;

	UmkmStoreFailedAction({required this.error});

	@override
	String toString() {
	return 'UmkmStoreFailedAction { error: $error }';
	}
}
	