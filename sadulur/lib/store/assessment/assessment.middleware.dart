import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_communication_assessment.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/collaboration_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/models/entrepreneurial_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';

CollectionReference assessmentCollection =
    FirebaseFirestore.instance.collection('assessments');
CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
CollectionReference storeCollection =
    FirebaseFirestore.instance.collection('stores');
Middleware<AppState> assessmentMiddleware = (store, action, next) {
  if (action is GetEntreprenurialAssessmentAction) {
    assessmentCollection
        .where('name', isEqualTo: "Entrepreneurial Assessment")
        .get()
        .then((value) async {
      DocumentSnapshot documents = value.docs.first;
      Map<String, dynamic> data = documents.data() as Map<String, dynamic>;
      List<String> questions = List<String>.from(data['questions'] ?? []);
      logger.d("222222");
      logger.d(questions);

      QuerySnapshot? entAssessmentSnapshot = await userCollection
          .doc(action.user.id)
          .collection('entrepreneurialAssessment')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      EntrepreneurialAssessment entAssessment =
          EntrepreneurialAssessment.empty();
      if (entAssessmentSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> entData =
            entAssessmentSnapshot.docs.first.data() as Map<String, dynamic>;
        logger.d(entData);
        entAssessment = EntrepreneurialAssessment.fromMap(entData);
      }
      store.dispatch(GetEntreprenurialAssessmentSuccessAction(
        questions: questions,
        entAssessment: entAssessment,
      ));
    }).catchError((error) {
      logger.e(error.toString());
      store.dispatch(AssessmentFailedAction(error: error.toString()));
    });
  } else if (action is GetCategoryAssessmentAction) {
    userCollection
        .doc(action.id)
        .collection("categoryAssessment")
        .orderBy("createdAt")
        .get()
        .then((value) {
      List<CategoryAssessment> categoryAssessmentList = [];
      logger.d("Assessment : ${value.size}");
      if (value.docs.isNotEmpty) {
        for (QueryDocumentSnapshot snapshot in value.docs) {
          CategoryAssessment assessment = CategoryAssessment.empty();
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          BusinessCommunicationAssessment businessComm =
              BusinessCommunicationAssessment.fromMap(data);

          BusinessFeasabilityAssessment businessFeas =
              BusinessFeasabilityAssessment.fromMap(data);
          CollaborationAssessment collaboration =
              CollaborationAssessment.fromMap(data);
          DecisionMakingAssessment decisionMaking =
              DecisionMakingAssessment.fromMap(data);
          DateTime createdAt = data['createdAt'].toDate();
          assessment = assessment.copyWith(
              businessComm: businessComm,
              businessFeas: businessFeas,
              collaboration: collaboration,
              decisionMaking: decisionMaking,
              createdAt: createdAt);
          categoryAssessmentList.add(assessment);
        }
      }
      store.dispatch(GetCategoryAssessmentSuccessAction(
          categoryAssessment: categoryAssessmentList));
    });
  } else if (action is AddEntreprenurialAssessmentAction) {
    DateTime createTime = DateTime.now();
    logger.d(action.assessment);
    userCollection
        .doc(action.user.id)
        .collection('entrepreneurialAssessment')
        .add({
      'assessment': action.assessment,
      'score': action.score,
      'characteristics': action.characteristic,
      'createdAt': createTime
    }).then((value) {
      EntrepreneurialAssessment entAssessment = EntrepreneurialAssessment(
          id: value.id,
          assessment: action.assessment,
          characteristics: action.characteristic,
          score: action.score,
          createdAt: createTime);
      store.dispatch(AddEntreprenurialAssessmentSuccessAction(
          payload: {"assessment": entAssessment, "updatedAt": createTime}));
    }).catchError((error) {
      store.dispatch(AssessmentFailedAction(error: error.toString()));
    });
    // userCollection.doc(action.user.id).update({
    //   'entrepreneuralAssessment': action.assessment,
    //   'entrepreneurialScore': action.score,
    //   'entrepreneurialType': action.characteristic,
    //   'updatedAt': updateTime
    // }).then((value) {
    //   // action.user.assessment.entrepreneuralAssessment = action.assessment;
    //   store.dispatch(AddEntreprenurialAssessmentSuccessAction(
    //       payload: {"assessment": action.assessment, "updatedAt": updateTime}));
    // }).catchError((error) {
    //   store.dispatch(AssessmentFailedAction(error: error.toString()));
    // });
  } else if (action is AddBasicAssessmentAction) {
    storeCollection.doc(action.store.id).set({
      'asset': action.asset,
      'revenue': action.revenue,
      'production': action.production,
      'permanentWorkers': action.permanentWorkers,
      'nonPermanentWorkers': action.nonPermanentWorkers
    }, SetOptions(merge: true)).then((value) {
      UMKMStore newStore = action.store.copyWith(
          totalRevenue: action.revenue,
          totalAsset: action.asset,
          productionCapacity: action.production,
          permanentWorkers: action.permanentWorkers,
          nonPermanentWorkers: action.nonPermanentWorkers,
          updatedAt: DateTime.now());

      store.dispatch(AddBasicAssessmentSuccessAction(payload: newStore));
    }).catchError((error) {
      store.dispatch(AssessmentFailedAction(error: error.toString()));
    });
  } else if (action is UpdateCategoryAssessmentAction) {
    var data = action.assessment;
    DateTime createdDate = DateTime.now();
    data.addAll({'createdAt': createdDate});
    userCollection
        .doc(action.user.id)
        .collection("categoryAssessment")
        .add(data)
        .then((value) {
      var level = "micro";
      if (data['score'] >= 6 && data['score'] <= 12) {
        level = 'small';
      } else if (data['score'] > 12) {
        level = 'medium';
      }
      storeCollection
          .doc(action.user.id)
          .update({'level': level}).then((userUpdate) {
        CategoryAssessment newAssessment = CategoryAssessment(
            id: value.id,
            businessComm: BusinessCommunicationAssessment.fromMap(data),
            businessFeas: BusinessFeasabilityAssessment.fromMap(data),
            collaboration: CollaborationAssessment.fromMap(data),
            decisionMaking: DecisionMakingAssessment.fromMap(data),
            createdAt: createdDate);
        var payload = {'level': level, 'assessment': newAssessment};
        store.dispatch(UpdateCategoryAssessmentSuccessAction(payload: payload));
      }).catchError((error) {
        store.dispatch(AssessmentFailedAction(error: error.toString()));
      });
    }).catchError((error) {
      store.dispatch(AssessmentFailedAction(error: error.toString()));
    });
  }

  next(action);
};
