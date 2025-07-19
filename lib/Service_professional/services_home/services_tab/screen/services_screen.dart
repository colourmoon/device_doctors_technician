import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/services_tab/model/services_model.dart';
import '../../../../comman/shimmers/shimmer_widget.dart';
import '../../../commons/common_images.dart';
import '../logic/cubit/services_cubit.dart';
import '../widget/services_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServicesCubit _servicesCubit;
  @override
  void initState() {
    _servicesCubit = ServicesCubit();
    _servicesCubit.sendquoate(fromUpdate: false);
    //  BlocProvider.of<ServicesCubit>(context);
    // _servicesCubit.sendquoate(fromUpdate: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ServicesCubit, ServicesState>(
        listener: (context, state) {
          // if (state.statusUpdatedSuccess == true) {
          //   _servicesCubit.sendquoate(fromUpdate: true);
          // }
          // TODO: implement listener
        },
        child: BlocBuilder<ServicesCubit, ServicesState>(
          bloc: _servicesCubit,
          builder: (context, state) {
            if (state.isLoading == true) {
              return ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: buildSimmer1(
                                height: 20,
                                width: 200,
                                radius: BorderRadius.all(Radius.circular(5.0))),
                          ),
                        ),
                        5.ph,
                        buildSimmer1(
                            height: 20,
                            width: 50,
                            radius: BorderRadius.all(Radius.circular(5.0)))
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.servicesList.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImages().noservicesImage,
                      0.ph,
                      const CommonProximaNovaTextWidget(
                        text: "No Services Selected!",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      3.ph,
                      const CommonProximaNovaTextWidget(
                        text: "Please Contact Admin",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state.error != "" && state.error != null) {
              return Center(
                child: CommonProximaNovaTextWidget(
                  text: state.error ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.servicesList.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: CommonProximaNovaTextWidget(
                        text: state.servicesList[i].categoryName,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    ListView.builder(
                        itemCount: state.servicesList[i].data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          child: ServicesWidget(
                              isItemLoading:
                                  state.servicesList[i].data[index].id ==
                                          state.selectedServiceId
                                      ? true
                                      : false,
                              title: state.servicesList[i].data[index].title,
                              isSelected: state.servicesList[i].data[index].status
                                          .toString() ==
                                      "1"
                                  ? true
                                  : false,
                              onTapFun: () {
                                _servicesCubit.updateServiceStatus(
                                    serviceId:
                                        state.servicesList[i].data[index].id,
                                    categoryId: state.servicesList[i].categoryId);
                                // context.read<ServicesCubit>().changeStatus(index);
                              }),
                        ))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
