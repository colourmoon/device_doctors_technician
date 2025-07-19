import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/terms_and_conditions/cubit/cms_data_cubit.dart';
import 'package:device_doctors_technician/comman/common_text.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final String title;
  const TermsAndConditionsScreen({super.key, required this.title});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<CmsDataCubit>().fetchCmsData(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: widget.title),
      backgroundColor: Colors.white,
      body: BlocBuilder<CmsDataCubit, CmsDataState>(
        builder: (context, cmsState) {
          if (cmsState.dataLoaded == false) {
            return Center(child: ThemeSpinner());
          } else if (cmsState.cmsError.isNotEmpty) {
            return Center(child: Text(cmsState.cmsError.toString()));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: cmsState.cmsData != null
                    ? HtmlWidget(cmsState.cmsData!.data.description)
                    : const SizedBox.shrink(),
              ),
            );
          }
        },
      ),
    );
  }
}
