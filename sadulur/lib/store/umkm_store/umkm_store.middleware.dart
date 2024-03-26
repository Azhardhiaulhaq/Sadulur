import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_communication_assessment.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/collaboration_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/models/entrepreneurial_assessment.dart';
import 'package:sadulur/models/store_product.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/models/user_assessment.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Middleware<AppState> umkmMiddleware = (store, action, next) async {
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  if (action is GetAllUmkmStoreAction) {
    FirebaseFirestore.instance.collection('stores').get().then((querySnapshot) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<UMKMStore> stores = documents.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String email = "";
        FirebaseFirestore.instance
            .collection('users')
            .doc(document.id)
            .get()
            .then((userDocument) {
          if (userDocument.exists) {
            Map<String, dynamic> userData =
                userDocument.data() as Map<String, dynamic>;
            email = userData['email'] ?? "";
          }
        });
        return UMKMStore(
            id: document.id,
            umkmName: data["umkmName"],
            description: data["description"],
            email: email,
            address: data["address"],
            city: data["city"],
            province: data["province"],
            phoneNumber: data["phoneNumber"],
            facebook: data["facebookAcc"],
            instagram: data["instagramAcc"],
            tokopedia: data["tokopediaName"],
            bukalapak: data["bukalapakName"],
            shopee: data["shopeeName"],
            photoProfile: data["profilePicture"],
            totalRevenue: data["revenue"] ?? 0,
            totalAsset: data["asset"] ?? 0,
            productionCapacity: data["production"] ?? 0,
            permanentWorkers: data["permanentWorkers"] ?? 0,
            nonPermanentWorkers: data["nonPermanentWorkers"] ?? 0,
            tags: List<String>.from(data['tags'] ?? []));
      }).toList();
      store.dispatch(GetAllUmkmStoreSuccessAction(payload: stores));
    }).catchError((error) {
      // Handle the error, such as dispatching an error action
      logger.e(error.toString());
      store.dispatch(UmkmStoreFailedAction(error: error.toString()));
    });
  } else if (action is GetUmkmStoreDetailAction) {
    userRef.doc(action.id).get().then((document) async {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // Map<String, dynamic> userData = value.data() as Map<String, dynamic>;
      QuerySnapshot? entAssessmentSnapshot = await userRef
          .doc(action.id)
          .collection('entrepreneurialAssessment')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      EntrepreneurialAssessment entAssessment =
          EntrepreneurialAssessment.empty();
      if (entAssessmentSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> entData =
            entAssessmentSnapshot.docs.first.data() as Map<String, dynamic>;
        entAssessment = EntrepreneurialAssessment.fromMap(entData);
      }

      QuerySnapshot catAssessmentSnapshot = await userRef
          .doc(action.id)
          .collection('categoryAssessment')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      CategoryAssessment categoryAssessment = CategoryAssessment.empty();
      if (catAssessmentSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> catData =
            catAssessmentSnapshot.docs.first.data() as Map<String, dynamic>;
        categoryAssessment = CategoryAssessment(
            id: catAssessmentSnapshot.docs.first.id,
            businessComm: BusinessCommunicationAssessment.fromMap(catData),
            businessFeas: BusinessFeasabilityAssessment.fromMap(catData),
            collaboration: CollaborationAssessment.fromMap(catData),
            decisionMaking: DecisionMakingAssessment.fromMap(catData),
            createdAt: catData['createdAt'].toDate());

        UserAssessment userAssessment = UserAssessment(
            basicAssessment: categoryAssessment,
            entrepreneurialAssessment: entAssessment);

        UMKMStore umkmStore = UMKMStore.empty();
        DocumentReference? storeRef = data["store"];

        if (storeRef != null) {
          DocumentSnapshot storeSnapshot = await storeRef.get();
          if (storeSnapshot.exists) {
            Map<String, dynamic> storeData =
                storeSnapshot.data() as Map<String, dynamic>;
            umkmStore =
                UMKMStore.fromMap(storeData, action.id, data['email'] ?? "");

            storeRef.collection('products').get().then((product) {
              List<StoreProduct> products = [];
              for (var element in product.docs) {
                Map<String, dynamic> data = element.data();
                StoreProduct product = StoreProduct(
                    id: element.id,
                    name: data['name'] ?? "No Product Name",
                    description: data['description'] ?? "No Description",
                    imageUrl: data['image'] ?? "",
                    price: data['price'] ?? 0,
                    seenNumber: data['seen'] ?? 0);

                products.add(product);
              }
            }).catchError((error) {
              logger.e(error);
              store.dispatch(UmkmStoreFailedAction(error: error.toString()));
            });
          }
        }
        // Map<String, dynamic> data, String id,
        // UserAssessment assessment, UMKMStore store
        UMKMUser userData =
            UMKMUser.fromMap(data, action.id, userAssessment, umkmStore);
        store.dispatch(GetUmkmStoreDetailSuccessAction(payload: userData));
      }
    }).catchError((error) {
      // Handle the error, such as dispatching an error action
      logger.e(error.toString());
      store.dispatch(UmkmStoreFailedAction(error: error.toString()));
    });
  } else if (action is GetAllStoreProductsAction) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(action.id)
        .collection('product')
        .get()
        .then((snapshot) {
      List<StoreProduct> products = [];
      for (var element in snapshot.docs) {
        Map<String, dynamic> data = element.data();

        StoreProduct product = StoreProduct(
            id: element.id,
            name: data['name'] ?? "No Product Name",
            description: data['description'] ?? "No Description",
            imageUrl: data['image'] ?? "",
            price: data['price'] ?? 0,
            seenNumber: data['seen'] ?? 0);

        products.add(product);
      }

      store.dispatch(GetAllStoreProdcutsSuccessAction(payload: products));
    }).catchError((error) {
      // Handle the error, such as dispatching an error action
      logger.e(error.toString());
      store.dispatch(UmkmStoreFailedAction(error: error.toString()));
    });
  } else if (action is UpdateUMKMStoreInfoAction) {
    DateTime updateTime = DateTime.now();

    FirebaseFirestore.instance.collection('stores').doc(action.store.id).set({
      "umkmName": action.request["umkmName"],
      "description": action.request["description"],
      "address": action.request["address"],
      "city": action.request["city"],
      "province": action.request["province"],
      "phoneNumber": action.request["phoneNumber"],
      "facebookAcc": action.request["facebookAcc"],
      "instagramAcc": action.request["instagramAcc"],
      "tokopediaName": action.request["tokopediaName"],
      "shopeeName": action.request["shopeeName"],
      "bukalapakName": action.request["bukalapakName"],
      "updatedAt": updateTime
    }, SetOptions(merge: true)).then((_) {
      logger.d("Success Update UMKM Store Info");
      UMKMStore newStore = action.store.copyWith(
          umkmName: action.request["umkmName"],
          description: action.request["description"],
          city: action.request["city"],
          province: action.request["province"],
          phoneNumber: action.request["phoneNumber"],
          facebook: action.request["facebookAcc"],
          instagram: action.request["instagramAcc"],
          tokopedia: action.request["tokopediaName"],
          bukalapak: action.request["bukalapakName"],
          shopee: action.request["shopeeName"],
          updatedAt: updateTime,
          address: action.request["address"]);

      FirebaseFirestore.instance.collection('users').doc(action.store.id).set({
        "name": action.request["name"],
        "age": int.parse(action.request["age"]),
        "education": action.request["education"],
        "updateAt": updateTime,
        "store":
            FirebaseFirestore.instance.collection('stores').doc(action.store.id)
      }, SetOptions(merge: true)).then((_) {
        logger.d("Success Update UMKM User Info");
        UMKMUser newUser = action.user!.copyWith(
            name: action.request["name"],
            age: int.parse(action.request["age"]),
            education: action.request["education"],
            updatedAt: updateTime,
            store: newStore);

        store.dispatch(UpdateUMKMStoreInfoSuccessAction(user: newUser));
      }).catchError((error) {
        logger.e(error.toString());
        store.dispatch(UmkmStoreFailedAction(error: error.toString()));
      });
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(UmkmStoreFailedAction(error: error.toString()));
    });
  } else if (action is UpdateUMKMPictureAction) {
    final file = action.file;
    final fileName = basename(file.path);
    final destination = 'profile_picture/$fileName';
    final storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(destination);
    // ignore: body_might_complete_normally_catch_error
    final uploadTask = storageRef.putFile(file).catchError((error) {
      store.dispatch(UmkmStoreFailedAction(error: error));
    });
    uploadTask.whenComplete(() {}).then((value) async {
      final downloadUrl = await value.ref.getDownloadURL();
      logger.d("${action.userID} + $downloadUrl");
      DateTime updatedTime = DateTime.now();
      FirebaseFirestore.instance.collection('stores').doc(action.userID).set(
          {"profilePicture": downloadUrl, "updatedAt": updatedTime},
          SetOptions(merge: true));
      UMKMStore newStore = action.store.copyWith(
          id: action.userID, photoProfile: downloadUrl, updatedAt: updatedTime);
      store.dispatch(UpdateUMKMPictureSuccessAction(store: newStore));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(UmkmStoreFailedAction(error: error.toString()));
    });
  }

  // Pass the action to the next middleware or the reducer
  next(action);
};
