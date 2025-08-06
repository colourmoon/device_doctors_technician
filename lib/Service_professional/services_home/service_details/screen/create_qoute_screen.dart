import 'dart:convert';

import 'package:device_doctors_technician/Service_professional/services_home/service_details/screen/service_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../logic/cubit/service_details_cubit.dart';
import '../logic/sendqoute/cubit/send_quote_cubit.dart';
import '../model/service_details_model.dart';
import '../widget/service_details_widget.dart';
import 'review_quote_screen.dart';

class CreateQuoteScreen extends StatefulWidget {
  final orderId, serviceId, totalamount;
  final paymentMode;
  final double costAmount;
  final List<VisitAndQuote> serviceItems;
  const CreateQuoteScreen(
      {super.key,
      required this.orderId,
      required this.paymentMode,
      required this.costAmount,
      required this.serviceId,
      required this.serviceItems,
      required this.totalamount});
  @override
  _CreateQuoteScreenState createState() => _CreateQuoteScreenState();
}

class _CreateQuoteScreenState extends State<CreateQuoteScreen> {
  List<MyForm> formWidgets = [];
  double _totalAmount = 0.0;

  void removeForm(int index) {
    setState(() {
      formWidgets.removeAt(index);
    });
  }

  List<jsonModel> formDataList = [];
  void submitForms() async{
    formDataList.clear(); // Make sure list is fresh

    for (MyForm form in formWidgets) {
      form.submitForm();
      formDataList.add(form.getFormData());
    }

    for (var formData in formDataList) {
      print("Username: ${formData.serviceName}, Additional Field: ${formData.amount}");
    }

    print("Submit All Forms clicked");
    String formDataListJson = jsonEncode(formDataList);
    print("List of Form Data: $formDataListJson");

    // Null safety check
    bool isIncomplete = formDataList.any((formData) =>
    (formData.serviceName ?? '').trim().isEmpty ||
        (formData.amount ?? '').trim().isEmpty);

    if (isIncomplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CommonToastwidget(toastmessage: "Please fill the details");
      });
    } else {

      double amountList = 0.0;

      try {
        amountList = formDataList.fold(0.0, (total, e) {
          final parsedAmount = double.tryParse('${e.amount ?? '0.00'}') ?? 0.0;
          return total + parsedAmount;
        });

        if (amountList <= widget.costAmount) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CommonToastwidget(
              toastmessage: "You cannot enter an amount less than or equal to the visit amount.",
            );
            return;
          });
        }else{
          context.read<SendQuoteCubit>().addquoate(
            orderId: widget.orderId ??"",
            serviceId: widget.serviceId ??"",
            servicesList: formDataList ??[],
          );
        }
      } catch (e) {
        print('Error calculating total amount: $e');
        amountList = 0.0;
      }



    }
  }


  @override
  void initState() {
    if (widget.serviceItems.isNotEmpty) {
      for (VisitAndQuote formData in widget.serviceItems) {
        formWidgets.add(MyForm(
          onRemove: () => removeForm(formWidgets.length),
          onAdd: () => addForm(),
          initialServiceName: formData.serviceName,
          initialAmount: formData.price,
          initialSerialNumber: formData.serialNumber,
          initialWarrantyDays: formData.warrantyDays,
          // Pass updateTotalAmount
        ));
      }
    } else {
      addForm();
    }
    super.initState();
  }

  double value = 0.0;

  void addForm() {
    setState(() {
      formWidgets.add(MyForm(
        onRemove: () => removeForm(formWidgets.length),
        onAdd: () => addForm(),
        // Provide initial values here for prefilling
        initialServiceName: "",
        initialAmount: "",
        initialSerialNumber: "",
        initialWarrantyDays: "",
      ));
    });
  }

  TextEditingController totalAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F0F5),
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Create Quote"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formWidgets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CommonProximaNovaTextWidget(
                                text: "SERVICE ${index + 1}",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            if (index != 0)
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  onTap: () => removeForm(index),
                                ),
                              ),
                          ],
                        ),
                        formWidgets[index],
                      ],
                    ),
                  ),
                );
              },
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: TextFormField(
            //     controller: totalAmountController,
            //     style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontSize: 15,
            //         color: Colors.black),
            //     decoration: InputDecoration(
            //       fillColor: Colors.white,
            //       filled: true,
            //       border: OutlineInputBorder(
            //         borderRadius: const BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //         borderSide: new BorderSide(
            //           color: Colors.transparent,
            //           width: 0.0,
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: const BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //         borderSide: new BorderSide(
            //           color: Colors.transparent,
            //           width: 0.0,
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: const BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //         borderSide: new BorderSide(
            //           color: Colors.transparent,
            //           width: 0.0,
            //         ),
            //       ),
            //       errorBorder: OutlineInputBorder(
            //         borderRadius: const BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //         borderSide: new BorderSide(
            //           color: Colors.red,
            //           width: 0.0,
            //         ),
            //       ),
            //       hintText: "Total Bill Amount",
            //       disabledBorder: InputBorder.none,
            //       // suffixIcon: suffixiconWidget,
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //       // hintText: hintText,
            //       hintStyle: const TextStyle(
            //         color: Color(0xFF222534),
            //         fontSize: 12,
            //         fontFamily: 'ProximaNova',
            //         fontWeight: FontWeight.w500,
            //       ),
            //       // prefixIcon: const Padding(
            //       //   padding: EdgeInsets.all(16),
            //       //   child: ImageIcon(
            //       //     AssetImage('assets/FoodRestaurant/user2342.png'),
            //       //     size: 10,
            //       //   ),
            //       // ),
            //     ),
            //     textAlign: TextAlign.start,
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Enter total bill amount';
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<SendQuoteCubit, SendQuoteState>(
            listener: (context, state) {
              if (state is AddQuotesuccess) {
                if (widget.serviceItems.isEmpty) {

                  context
                      .read<NewOrdersCubit>()
                      .fetchNewOrders(type: "ongoing");
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ReviewQuoteScreen(
                          total: totalAmountController.text,
                          orderId: widget.orderId,
                          serviceId: widget.serviceId,paymentMode: widget.paymentMode,
                        ),
                      ));
                } else {
                  Navigator.pop(context);

                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ReviewQuoteScreen(
                          total: totalAmountController.text,
                          orderId: widget.orderId,
                          serviceId: widget.serviceId, paymentMode: widget.paymentMode,
                        ),
                      ));
                }
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return SwipeButtons(
                isLoading: state is AddQuoteerror ? true : false,
                onButtonDragged: () {
                  submitForms();
                  // bottomSheet();
                },
                buttontitle: "REVIEW QUOTE",
              );
            },
          ),
          // ElevatedButton(
          //   onPressed: submitForms,
          //   child: Text('Submit All Forms'),
          // ),
          TextButton(
              onPressed: () {

                OrderDetailsScreenState.completeServiceBottomSheet(servicecubit:
                context.read<ServiceDetailsCubit>(),gcontext: context, paymentMode: widget.paymentMode, success: () {

                  print('⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙1');
                  successSheet(context,() {
                    successSheet(context,() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const ServicesBottomBarScreen(initialIndex: 1),
                        ),
                            (route) => false,
                      );
                    },);
                  },);
                },);
              },
              child: const CommonProximaNovaTextWidget(
                text: "Mark As Completed?",
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
class MyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController;
  final TextEditingController additionalFieldController;
  final TextEditingController serialNumberController;
  final TextEditingController warrantyDaysController;

  final VoidCallback onRemove;
  final VoidCallback onAdd;

  MyForm({super.key,
    required this.onRemove,
    required this.onAdd,
    String? initialServiceName,
    String? initialAmount,
    String? initialSerialNumber,
    String? initialWarrantyDays,
  })  : usernameController = TextEditingController(text: initialServiceName),
        additionalFieldController = TextEditingController(text: initialAmount),
        serialNumberController = TextEditingController(text: initialSerialNumber),
        warrantyDaysController = TextEditingController(text: initialWarrantyDays);

  void submitForm() {
    formKey.currentState?.save();
  }

  jsonModel getFormData() {
    return jsonModel(
      serviceName: usernameController.text,
      amount: additionalFieldController.text,
      serialNumber: serialNumberController.text,
      warrantyDays: warrantyDaysController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),

          // Service Title Field
          TextFormField(
            controller: usernameController,
            decoration: inputDecoration("Service Title"),
            validator: (value) => value!.isEmpty ? 'Enter service title' : null,
          ),

          const SizedBox(height: 12.0),

          // Amount and Add Button Row
          TextFormField(
            controller: additionalFieldController,
            keyboardType: TextInputType.number,
            decoration: inputDecoration("Enter Cost"),
            validator: (value) => value!.isEmpty ? 'Enter amount' : null,
          ),

          const SizedBox(height: 12.0),

          // Serial Number Field
          TextFormField(
            controller: serialNumberController,
            keyboardType: TextInputType.text,
            decoration: inputDecoration("Enter Serial Number"),
            validator: (value) => value!.isEmpty ? 'Enter serial number' : null,
          ),

          const SizedBox(height: 12.0),
          // Amount and Add Button Row
          Row(
            children: [
              Expanded(
                child:   // Warranty Days Field
                TextFormField(
                  controller: warrantyDaysController,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration("Enter Warranty Days"),
                  validator: (value) => value!.isEmpty ? 'Enter warranty days' : null,
                ),
              ),
              const SizedBox(width: 8),
              if (onAdd != null)
                InkWell(
                  onTap: onAdd,
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      hintStyle: const TextStyle(
        color: Color(0xFF222534),
        fontSize: 12,
        fontFamily: 'ProximaNova',
        fontWeight: FontWeight.w500,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Colors.red, width: 0.0),
      ),
      disabledBorder: InputBorder.none,
    );
  }
}

class jsonModel {
  String serviceName;
  String amount;
  String serialNumber;
  String warrantyDays;

  jsonModel({
    required this.serviceName,
    required this.amount,
    required this.serialNumber,
    required this.warrantyDays,
  });

  Map<String, dynamic> toJson() {
    return {
      'service_name': serviceName,
      'amount': amount,
      'serial_number': serialNumber,
      'warrenty_days': warrantyDays,
    };
  }
}

