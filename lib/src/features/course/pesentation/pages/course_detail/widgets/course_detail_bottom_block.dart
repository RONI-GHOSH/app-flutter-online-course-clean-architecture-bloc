import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/data/datasources/account_courses_list.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/widgets/custom_button.dart';
import 'package:online_course/src/theme/app_color.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:rive/rive.dart';

class CourseDetailBottomBlock extends StatefulWidget {
   CourseDetailBottomBlock({required this.course, super.key});

  final Course course;

  @override
  State<CourseDetailBottomBlock> createState() => _CourseDetailBottomBlockState();
}

class _CourseDetailBottomBlockState extends State<CourseDetailBottomBlock> {
   late Razorpay _razorpay;

   @override
  void initState() {
   
    super.initState();
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

  void openCheckout() async {
    int price =int.parse(widget.course.price.toString());
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': price*100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
   int status =  await addCourseToAccount(widget.course.id);
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
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
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
                      text: widget.course.price,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColor.textColor,
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
                openCheckout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
