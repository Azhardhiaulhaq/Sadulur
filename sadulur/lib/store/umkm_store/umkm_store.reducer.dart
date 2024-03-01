import 'package:redux/redux.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import './umkm_store.state.dart';

final umkmstoreReducer = combineReducers<UmkmStoreState>([umkmStoreReducerAll]);

UmkmStoreState umkmStoreReducerAll(UmkmStoreState state, dynamic action) {
  UmkmStoreState newState = state;

  if (action is GetAllUmkmStoreAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is GetAllUmkmStoreSuccessAction) {
    newState =
        state.copyWith(loading: false, error: null, umkmStores: action.payload);
  } else if (action is UmkmStoreFailedAction) {
    newState = state.copyWith(loading: false, error: action.error);
  } else if (action is GetUmkmStoreDetailAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is GetUmkmStoreDetailSuccessAction) {
    newState = state.copyWith(loading: false, error: null);
  } else if (action is GetAllStoreProductsAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is GetAllStoreProdcutsSuccessAction) {
    // state.storeDetail!.addListProduct(action.payload);
    // newState = state.copyWith(
    //     loading: false, error: null, storeDetail: state.storeDetail);
  } else if (action is UpdateUMKMStoreInfoAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is UpdateUMKMStoreInfoSuccessAction) {
    newState = state.copyWith(loading: false, error: null);
  } else if (action is UpdateUMKMPictureAction) {
    newState = state.copyWith(loading: true, error: null);
  } else if (action is UpdateUMKMPictureSuccessAction) {
    // state.storeDetail?.changePhotoProfile(action.downloadUrl);

    newState = state.copyWith(loading: false, error: null);
  }
  return newState;
}
