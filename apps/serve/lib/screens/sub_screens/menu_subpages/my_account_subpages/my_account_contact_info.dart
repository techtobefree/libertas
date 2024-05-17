import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';

class MyAccountContactInfo extends StatefulWidget {
  const MyAccountContactInfo({super.key});

  @override
  State<MyAccountContactInfo> createState() => _MyAccountContactInfoState();
}

class _MyAccountContactInfoState extends State<MyAccountContactInfo> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final List<String> privacyOptions = ['Friends', 'Public'];

  final String placeholder =
      "18921 Clearview Lane askjdhflasdjhflajdhfasdfasdfadsfadfasfads";

  void _submitForm() {
    // a null check on here?
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // Get the value of each form field and add it to the _formData map
      _formKey.currentState!.save();
      debugPrint(_formKey.currentState!.value.toString());
      // Do something with the form data
      print(_formKey.currentState!.value);
      //context.go(widget._path);
    }
  }

  InputDecoration _fieldDecoration(hintText) {
    return InputDecoration(
      hintText: hintText,
      // For some reason this does not work if I am only styling one or two borders. So I specified all 4 down below.
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(16),
      fillColor: Colors.grey[200],
      filled: true,
      // Many other way to customize this to make it feel interactive, otherwise the enabledBorder and the focusedBorder can just be deleted.
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Project Demo'),
        ),
        body: SingleChildScrollView(
            child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Address",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: FormBuilderTextField(
                          name: 'address',
                          initialValue: placeholder,
                          validator: ValidationBuilder().required().build(),
                          
                          
                          
                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                            // FormBuilderValidators.minLength(3),
                            // FormBuilderValidators.maxLength(50),
                            // FormBuilderValidators.match(
                            //   r'^[a-zA-Z0-9]+$',
                            //   errorText:
                            //       'Only alphanumeric characters are allowed',
                            // ),
                          // ]),
                          decoration: _fieldDecoration("Address")),
                    ),
                    Container(height: 20),
                    const Text(
                      "City",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: FormBuilderTextField(
                          name: 'city',
                          validator: ValidationBuilder()
    .required()
    .regExp(
      RegExp(r'^[a-zA-Z]+$'),
      'Only alphabetic characters are allowed',
    )
    .build(),
                          
                          
                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          //   FormBuilderValidators.match(
                          //     r'^[a-zA-Z]+$',
                          //     errorText:
                          //         'Only alphanumeric characters are allowed',
                          //   ),
                          // ]),
                          decoration: _fieldDecoration("City")),
                    ),
                    Container(height: 20),
                    const Text(
                      "State",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: FormBuilderTextField(
                          name: 'state',
                          //initialValue: "October 12, 1998",
                          validator: ValidationBuilder().required().build(),
                          
                          
                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          // ]),
                          decoration: _fieldDecoration("State")),
                    ),
                    Container(height: 20),
                    const Text(
                      "Zip Code",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: FormBuilderTextField(
                          name: 'zipcode',
                          //initialValue: "October 12, 1998",
                          validator: ValidationBuilder()
    .required()
    .regExp(
      RegExp(r'^[a-zA-Z]+$'),
      'Only alphabetic characters are allowed',
    )
    .build(),
                          
                          
                          
                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          //   FormBuilderValidators.match(
                          //     r'^[0-9]+$',
                          //     errorText:
                          //         'Only alphanumeric characters are allowed',
                          //   ),
                          // ]),
                          decoration: _fieldDecoration("Zip Code")),
                    ),
                    Container(height: 20),
                    const Text(
                      "Phone",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: FormBuilderTextField(
                          name: 'phone',
                          //initialValue: "October 12, 1998",
                          validator: ValidationBuilder()
    .required()
    .regExp(
      RegExp(r'^[0-9]+$'),
      'Only alphabetic characters are allowed',
    )
    .build(),
                          
                          
                          
                          // FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(),
                          //   FormBuilderValidators.match(
                          //     r'^[0-9]+$',
                          //     errorText:
                          //         'Only numeric characters are allowed',
                          //   ),
                          // ]),
                          decoration: _fieldDecoration("Phone Number")),
                    ),
                  ],
                ),
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.only(bottom: 50),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    //side: BorderSide(width: 2.5, color: Colors.black),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
