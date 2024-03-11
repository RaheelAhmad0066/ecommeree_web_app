import 'dart:typed_data';
import 'package:ecommerce/model/bussiness_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/dimens.dart';
import '../widgets/custom_field_widget.dart';

String companyname = '';
String compnyaddress = '';
String companyphone = '';
String companyemail = '';

class NewBusinessScreen extends StatefulWidget {
  NewBusinessScreen({Key? key}) : super(key: key);

  @override
  State<NewBusinessScreen> createState() => _NewBusinessScreenState();
}

class _NewBusinessScreenState extends State<NewBusinessScreen> {
  final companyNameCont = TextEditingController();
  final addressCont = TextEditingController();
  final phoneNumberCont = TextEditingController();
  final companyEmail = TextEditingController();

  void _savedData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    BussinessModal bussinessModal = BussinessModal(
        // imagepath: imagePath,
        address: addressCont.text,
        companyEmail: companyEmail.text,
        companyName: companyNameCont.text,
        phonenumber: phoneNumberCont.text);

    pref.setString('company_email', bussinessModal.companyEmail);
    pref.setString('company_name', bussinessModal.companyName);
    pref.setString('company_address', bussinessModal.address);
    pref.setString('company_number', bussinessModal.phonenumber);

    companyNameCont.clear();
    addressCont.clear();
    phoneNumberCont.clear();
    companyEmail.clear();
  }

  void getuserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      companyname = pref.getString('company_name') ?? '';
      compnyaddress = pref.getString('company_address') ?? '';
      companyphone = pref.getString('company_number') ?? '';
      companyemail = pref.getString('company_email') ?? '';
    });
  }

  // void imagepicker() async {
  //   final image = ImagePicker();
  //   final picker = await image.pickImage(source: ImageSource.gallery);
  //   if (picker != null) {
  //     List<int> imagebyte = await picker.readAsBytes();
  //     String imageb = base64Encode(imagebyte);
  //     setState(() {
  //       imageByte = imageb as List<int>?;
  //     });
  //   }
  // }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text('saved'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PortalMasterLayout(
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Business Details',
                style: themeData.textTheme.headlineMedium,
              ),
              const Text(
                'add your business details',
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Column(
                children: [
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Business Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: companyNameCont,
                        title: 'add your company details',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Address*',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: companyEmail,
                        title: 'add your company email',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phone Number*',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: phoneNumberCont,
                        title: 'add your phone number',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wire Informations',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: phoneNumberCont,
                        title: 'add your wire information',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        minLine: 4,
                        maxline: 10,
                        controller: addressCont,
                        title: 'add your address',
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.05,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as per your preference
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors
                                .green), // Change the color to your desired one
                          ),
                          onPressed: () {
                            _savedData();
                            getuserData();
                            _showSharedToast(context);
                          },
                          child: const Text(
                            'Saved',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
