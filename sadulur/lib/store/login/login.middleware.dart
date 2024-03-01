import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_communication_assessment.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/collaboration_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/models/entrepreneurial_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/models/user_assessment.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/login/login.action.dart';

Middleware<AppState> loginMiddleware = (store, action, next) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  if (action is LoginAction) {
    // FirebaseAuth.instance
    //     .signInWithEmailAndPassword(
    //         email: action.email, password: action.password)
    //     .then((userCredential) async {
    //   User? user = userCredential.user;
    //   if (user != null) {
    //     try {
    //       DocumentReference userReference =
    //           FirebaseFirestore.instance.collection('users').doc(user.uid);

    //       DocumentSnapshot userSnapshot = await userReference.get();
    //       if (userSnapshot.exists) {
    //         Map<String, dynamic> userData =
    //             userSnapshot.data() as Map<String, dynamic>;
    //         QuerySnapshot? categorySnapshot =
    //             await userReference.collection('categoryAssessment').get();

    //         CategoryAssessment assessment = CategoryAssessment.empty();
    //         if (categorySnapshot.docs.isNotEmpty) {
    //           DocumentSnapshot firstDocument = categorySnapshot.docs.first;
    //           Map<String, dynamic> data =
    //               firstDocument.data() as Map<String, dynamic>;
    //           assessment = assessment.copyWith(
    //               formality: data["formality"] ?? "",
    //               organisation: data["organisation"] ?? "",
    //               usedWorkers: data["usedWorkers"] ?? "",
    //               genderOwner: data["genderOwner"] ?? "",
    //               marketOrientation: data["marketOrientation"] ?? "",
    //               motivation: data["motivation"] ?? "",
    //               productionProcess: data["productionProcess"] ?? "",
    //               profileOwner: data["profileOwner"] ?? "",
    //               spirit: data["spirit"] ?? "",
    //               techUsed: data["techUsed"] ?? "");
    //         }
    //         // UserAssessment userAssessment = UserAssessment(
    //         //     entrepreneuralAssessment:
    //         //         List.from(userData['entrepreneuralAssessment'] ?? []),
    //         //     basicAssessment: assessment);

    //         UMKMStore umkmStore = UMKMStore.empty();
    //         DocumentReference? storeRef = userData["store"];
    //         if (storeRef != null) {
    //           DocumentSnapshot storeSnapshot = await storeRef.get();
    //           if (storeSnapshot.exists) {
    //             Map<String, dynamic> storeData =
    //                 storeSnapshot.data() as Map<String, dynamic>;
    //             umkmStore =
    //                 UMKMStore.fromMap(storeData, user.uid, action.email);
    //           }
    //         }

    //         UMKMUser umkmUser =
    //             UMKMUser.fromMap(userData, user.uid, userAssessment, umkmStore);
    //         store.dispatch(LoginSuccessAction(payload: umkmUser));
    //       }
    //     } catch (error) {
    //       logger.e(error);
    //       store.dispatch(LoginFailedAction(error: error.toString()));
    //     }
    //   }
    // }).catchError((error) {
    //   logger.e(error);
    //   store.dispatch(LoginFailedAction(error: error.toString()));
    // });
  } else if (action is GetUserDetailAction) {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(action.userID);

    userRef.get().then((value) async {
      Map<String, dynamic> userData = value.data() as Map<String, dynamic>;
      QuerySnapshot? entAssessmentSnapshot = await userRef
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
        DocumentReference? storeRef = userData["store"];
        if (storeRef != null) {
          DocumentSnapshot storeSnapshot = await storeRef.get();
          if (storeSnapshot.exists) {
            Map<String, dynamic> storeData =
                storeSnapshot.data() as Map<String, dynamic>;
            umkmStore = UMKMStore.fromMap(
                storeData, action.userID, userData['email'] ?? "");
          }
        }

        UMKMUser user = UMKMUser.fromMap(
            userData, action.userID, userAssessment, umkmStore);
        logger.d(user.assessment.entrepreneurialAssessment.assessment);

        store.dispatch(GetUserDetailSuccessAction(user: user));
      }
    }).catchError((error) {
      store.dispatch(GetUserDetailFailedAction(error: error.toString()));
    });
  } else if (action is RegistrationAction) {
    _auth
        .createUserWithEmailAndPassword(
            email: action.email, password: action.password)
        .then((userCredential) {
      userCredential.user?.updateDisplayName(action.userName);
      Timestamp dateNow = Timestamp.now();
      UMKMUser umkmUser = UMKMUser(
          email: action.email,
          userName: action.userName,
          createdAt: dateNow.toDate(),
          updatedAt: dateNow.toDate(),
          id: userCredential.user?.uid ?? "",
          assessment: UserAssessment.empty(),
          isAdmin: false,
          store: UMKMStore.empty());

      userCollection.doc(userCredential.user?.uid).set({
        'email': action.email,
        'username': action.userName,
        'isAdmin': false,
        'uid': userCredential.user?.uid,
        'updatedAt': dateNow,
      }).then((value) {
        store.dispatch(RegistrationSuccessAction(payload: umkmUser));
      }).catchError((error) {
        logger.e(" --- ${error.toString()}");
        store.dispatch(RegistrationFailedAction(error: error.toString()));
      });
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(RegistrationFailedAction(error: error.toString()));
    });
  }
  next(action);
};
