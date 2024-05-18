import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/data/datasources/account_courses_list.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/widgets/custom_button.dart';
import 'package:online_course/src/theme/app_color.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:rive/rive.dart';

class CourseDetailBottomBlock extends StatefulWidget {
   const CourseDetailBottomBlock({required this.course, super.key, required this.subjects});

  final Course course;
   final Map<String, int> subjects;

  @override
  State<CourseDetailBottomBlock> createState() => _CourseDetailBottomBlockState();
}

class _CourseDetailBottomBlockState extends State<CourseDetailBottomBlock> {
   late Razorpay _razorpay;


    Map<int,String> pricing = {};
  List<int> selectedForPayment = [];
  bool _isProcessing = false;
   


   @override
  void initState() {
   
    super.initState();
    // getPrice();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String? pricee) async {
   if(pricee==null){
     return;
   }
    int price =int.parse(pricee.toString());
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': price*100,
      'name': 'Examplan B',
      'image': 'assets/images/examplan_b_logo.png',
      'description': 'Online Course',
      'theme': {'color': '#2C4BD9'}
      
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    setState(() {
       _isProcessing =true;
    });
   
   int status =  await addCourseToAccount(widget.course.id,selectedForPayment );
   _isProcessing =false;
   if(status == 200){
      _showResponse('Payment Successful',response.paymentId);
   }else{
       _showResponse('Payment Failed',response.paymentId);
   }
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if(response.code != Razorpay.PAYMENT_CANCELLED){
        _showResponse('Payment Error',null);
    }
  
   
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
   _showResponse('External wallets are not allowed',null);
   
  }

  void _showResponse(String status, String? paymentId){
   showFlexibleBottomSheet(
  minHeight: 0,
  initHeight: 0.5,
  maxHeight: 1,
  context: context,
  builder: (context, scrollController, bottomSheetOffset) {
      return _buildBottomSheet(context,status,paymentId);
    },
  anchors: [0, 0.5, 1],
  isSafeArea: true,
);


  }
Widget _buildBottomSheet(BuildContext context, String message, [String? paymentId]) {
  return Material(
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
        
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: message.contains('Successful'
              ) ?const RiveAnimation.asset('assets/anim/succes.riv'): const SizedBox(),
            ),
            const SizedBox(height: 20,),
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10,),
            Text("Payment ID : ${paymentId ?? 'N/A'}", style: const TextStyle(fontSize: 14),),
            const SizedBox(height: 20,),
           
          ],
        ),
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    bool _isloading = false;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: !_isProcessing ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Price",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.labelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Rs. ${widget.course.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: CustomButton(
              radius: 10,
              title: "Buy Now",
              onTap: () {
               showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Select an option'),
                  children: !_isloading? widget.subjects.keys.map((String subject) {
                    return SimpleDialogOption(
                      onPressed: () async {


                         if(widget.subjects[subject] == 0){


                         selectedForPayment.addAll(widget.subjects.values.toList().cast<int>());

                          openCheckout(widget.course.price);
                         }else{
                          _isloading = true;
                            await getPrice();
                            _isloading = false;
                            selectedForPayment.add(widget.subjects[subject]??0);
                            openCheckout(pricing[widget.subjects[subject]]??widget.course.price);
                         }
                        
                        Navigator.pop(context,widget.subjects[subject]);
                      },
                      child: Text(subject),
                    );
                  }).toList() : [const CircularProgressIndicator()],
                );
              },
            );
              },
            ),
          ),
        ],
      ):const Center(
        child: CircularProgressIndicator(),
      )
      ,
    );
  }

  Future<void> getPrice() async {
       QuerySnapshot snapshot =await  FirebaseFirestore.instance.collection('courses').where('id' , isEqualTo: widget.course.id).get();
    // ignore: unnecessary_null_comparison
    if(snapshot!=null && snapshot.docs!=null){
        var data =  snapshot.docs[0].data() as  Map<String, dynamic> ;
    
        (data['pricing'] as Map<dynamic, dynamic>).forEach((key, value) {
            pricing[int.parse(key)] = value as String; // Assuming values are always string
        });
        
        setState(() {
          
        });
        
        print(pricing);
    }
  }
}
