// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:giftcardbalancechecker/db/db_model.dart';
// import 'package:get/get.dart';

// class CardController extends GetxController {
//   final CollectionReference _collectionReference =
//       FirebaseFirestore.instance.collection('Card Details');

//   Stream<List<CardDetails>> cardList() {
//     return _collectionReference.snapshots().map((snapshot) {
//       List<CardDetails> cardList = snapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         final id = doc.id;
//         return CardDetails.fromJson(data, id);
//       }).toList();

//       // Sort the list by the `time` field in descending order (newest first)
//       cardList.sort((a, b) => b.time.compareTo(a.time));

//       return cardList;
//     });
//   }

//   Future<void> deleteCard(String cardId) async {
//     await _collectionReference.doc(cardId).delete();
//   }

//   Future<void> addCard(CardDetails cardDetails) async {
//     try {
//       await _collectionReference.add(cardDetails.toMap());

//       // Log success message
//       print('Card added successfully to Firestore.');

//       // controller.animateToPage(0,
//       //     duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
//     } catch (error) {
//       // _showCheckBalanceDialog();
//     }
//   }
// }
