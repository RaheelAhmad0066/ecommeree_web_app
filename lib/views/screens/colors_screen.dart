import 'package:flutter/material.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/theme/theme_extensions/app_color_scheme.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/portal_master_layout.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/dimens.dart';
import '../../model/customer.dart';
import '../widgets/custom_field_widget.dart';

String customername = '';
String customeremail = '';
String customeraddress = '';
String customerphone = '';
String customerdate = '';

class CreateCustomer extends StatefulWidget {
  CreateCustomer({Key? key}) : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  List<String> items = ['your email', 'whatsapp'];
  final userNameCont = TextEditingController();
  final addressCont = TextEditingController();
  final phoneNumberCont = TextEditingController();
  final userEmail = TextEditingController();
  final dateControler = TextEditingController();

  bool value = false;
  bool value1 = false;
  bool value2 = false;

  void _savedData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Customer customer = Customer(
        name: userNameCont.text,
        address: addressCont.text,
        email: userEmail.text,
        phonenumber: phoneNumberCont.text,
        date: dateControler.text);
    pref.setString('customer_name', customer.name);
    pref.setString('customer_email', customer.email);
    pref.setString('customer_address', customer.address);
    pref.setString('customer_date', customer.date);
    pref.setString('customer_phone', customer.phonenumber);

    userNameCont.clear();
    addressCont.clear();
    phoneNumberCont.clear();
    userEmail.clear();
    dateControler.clear();


  }

  void getuserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      customername = pref.getString('customer_name') ?? '';
      customeremail = pref.getString('customer_email') ?? '';
      customeraddress = pref.getString('customer_address') ?? '';
      customerdate = pref.getString('customer_date') ?? '';
      customerphone = pref.getString('customer_phone') ?? '';
    });
  }
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
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = Theme.of(context).extension<AppColorScheme>()!;

    return PortalMasterLayout(
        body: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create new Customer',
                style: themeData.textTheme.headlineMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.2,
                      child: ClipOval(
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('Select image'))
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        CustomField(
                          controller: userNameCont,
                          title: 'enter your first name',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Last Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        CustomField(
                          controller: TextEditingController(),
                          title: 'enter your last name',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        CustomField(
                          controller: userEmail,
                          title: 'enter your email',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        CustomField(
                          controller: phoneNumberCont,
                          title: '0309-0320-565',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bill Address',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  CustomField(
                    minLine: 4,
                    maxline: 10,
                    controller: addressCont,
                    title: 'enter your address',
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ship Address',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  CustomField(
                    minLine: 4,
                    maxline: 10,
                    controller: addressCont,
                    title: 'enter your address',
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date*',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                        FormBuilderDateTimePicker(
                          name: 'date_picker',
                          controller: dateControler,
                          onChanged: (value) {},
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          initialTime: const TimeOfDay(hour: 8, minute: 0),
                          initialValue: DateTime.now(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: constraints.maxHeight * 0.02),
              const Text(
                'Invoice Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              ListTile(
                leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val!;
                      });
                    }),
                title: Text('Email'),
              ),
              ListTile(
                leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    value: value1,
                    onChanged: (val) {
                      setState(() {
                        value1 = val!;
                      });
                    }),
                title: Text('Phone number'),
              ),
              SizedBox(height: constraints.maxHeight * 0.04),
              Center(
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.05,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
              const SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      );
    }));
  }
}
