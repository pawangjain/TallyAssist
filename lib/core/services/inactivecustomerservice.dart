import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/inactivecustomer.dart';

class InactiveCustomerService {
  final String uid;
  
  InactiveCustomerService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

      Stream<List<InactiveCustomer>> get inactiveCustomerData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .where('closing_balance', isEqualTo: 0)
        .where('restat_primary_group_type', isEqualTo: 'Sundry Debtors')
        .orderBy('closing_balance', descending: false)
        .snapshots()
        .map(_inactiveCustomerData);
  }

  

  List<InactiveCustomer> _inactiveCustomerData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return InactiveCustomer(
        name: doc.data['name'] ?? '',
        masterId: doc.data['master_id'] ?? '',
        currencyName: doc.data['currencyname'] ?? '',
        openingBalance: doc.data['opening_balance'].toString() ?? '',
        closingBalance: doc.data['closing_balance'].toString() ?? '',
        parentid: doc.data['parentcode'] ?? '',
        contact: doc.data['contact'] ?? '',
        state: doc.data['state'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['phone'] ?? '',
        guid: doc.data['guid'] ?? '',
        lastPaymentDate: doc.data['restat_last_payment_date'] ?? '',
          lastPurchaseDate: doc.data['restat_last_purchase_date'] ?? '',
          lastReceiptDate: doc.data['restat_last_receipt_date'] ?? '',
          lastSalesDate: doc.data['restat_last_sales_date'] ?? '',
          meanPayment: doc.data['restat_mean_payment'].toString()?? '',
          meanPurchase: doc.data['restat_mean_purchase'].toString() ?? '',
          meanReceipt: doc.data['restat_mean_receipt'].toString() ?? '',
          meanSales: doc.data['restat_mean_sales'].toString() ?? '',
          partyGuid: doc.data['restat_party_guid'].toString() ?? '',
          totalPayables: doc.data['restat_total_payables'].toString() ?? '',
          totalPayment: doc.data['restat_total_payment'].toString() ?? '',
          totalPurchase: doc.data['restat_total_purchase'].toString() ?? '',
          totalReceipt: doc.data['restat_total_receipt'].toString() ?? '',
          totalReceivables: doc.data['restat_total_receivables'].toString() ?? '',
          primaryGroupType: doc.data['restat_primary_group_type'].toString() ?? '',
      );
    }).toList();
  }
}