// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   InAppPurchase inAppPurchase = InAppPurchase.instance;
//   StreamSubscription<List<PurchaseDetails>>? subscription;
//   List<PurchaseDetails> purchaseDetailsList = [];
//   List<PurchaseDetails> _purchases = [];
//   bool purchased = false;
//   bool _purchasePending = false;
//
//
//   getPurchases({required purchaseDetails}){
//     if (purchaseDetails.productID == "monthly") {
//       setState(() {
//         _purchasePending = false;
//       });
//     } else {
//       setState(() {
//         _purchases.add(purchaseDetails);
//         _purchasePending = false;
//       });
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     subscription = inAppPurchase.purchaseStream.listen(
//       (List<PurchaseDetails> purchaseDetailsList) {
//        purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) {
//          if(purchaseDetails.status==PurchaseStatus.purchased){
//            Fluttertoast.showToast(
//                msg: purchaseDetails.toString(),
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.CENTER,
//                timeInSecForIosWeb: 1,
//                backgroundColor: Colors.red,
//                textColor: Colors.white,
//                fontSize: 16.0
//            );
//            setState(() {
//              purchased = true;
//            });
//            getPurchases(purchaseDetails: purchaseDetails);
//          }
//        });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In App Purchase"),
//         actions: [
//           !purchased?  IconButton(
//             onPressed: () async {
//               ProductDetailsResponse productsDetailsResponse =
//                   await inAppPurchase
//                       .queryProductDetails(Set.from(["monthly", "yearly"]));
//               Get.bottomSheet(
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   height: 300,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Remove Ads",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "Subsucribe to Remove all the Ads",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount:
//                               productsDetailsResponse.productDetails.length,
//                           itemBuilder: (context, index) {
//                             bool purchased = false;
//                             for (PurchaseDetails purchaseDetails
//                                 in purchaseDetailsList) {
//                               if (purchaseDetails.productID ==
//                                   productsDetailsResponse
//                                       .productDetails[index].id) {
//                                 setState(() {
//                                   purchased = true;
//                                 });
//                               }
//                             }
//                             return GestureDetector(
//                               onTap: () {
//                                 // final GooglePlayPurchaseDetails? oldSubscription =
//                                 // _getOldSubscription(productDetails, purchases);
//                                 if (!purchased) {
//                                   PurchaseParam purchaseParam = PurchaseParam(
//                                       productDetails: productsDetailsResponse
//                                           .productDetails[index]);
//
//                                   inAppPurchase.buyNonConsumable(
//                                       purchaseParam: purchaseParam);
//                                 }
//                               },
//                               child: Container(
//                                 height: 80,
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 padding: EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: purchased ? Colors.red : Colors.green,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       width: 300,
//                                       child: Text(
//                                         productsDetailsResponse
//                                             .productDetails[index].title,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 18,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "${productsDetailsResponse.productDetails[index].price}",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//             icon: Icon(
//               Icons.paid_rounded,
//             ),
//           ):SizedBox(),
//         ],
//       ),
//       // body: Text("${purchaseDetailsList.length}"),
//       body: ListView.builder(
//         itemCount: _purchases.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Column(
//               children: [
//                 Text("${_purchases[index].productID}"),
//                 Text("${_purchases[index].status}"),
//                 Text("${_purchases[index].purchaseID}"),
//                 Text("${_purchases[index].transactionDate}"),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
