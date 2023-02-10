import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/custom_form_field.dart';

class TestForm extends HookConsumerWidget {
  const TestForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    // displays a form to users and allows submitting
    // users can enter their name, whatsapp number and select a date
    // after submitting, the fields are validated and the user is redirected to a success page
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pine Timber',
              style: kFormTitleTextStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.park,
              color: Colors.white,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Form(
          key: formKey.value,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            children: [
              const SizedBox(height: 32.0),
              Text(
                'Cutting List Order Form',
                style: kFormTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              CustomFormField(
                labelText: 'Name',
                keyText: 'name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomFormField(
                labelText: 'WhatsApp Number',
                keyText: 'whatsapp',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                  LengthLimitingTextInputFormatter(12),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your WhatsApp number';
                  }
                  if (!value.startsWith('+27') && !value.startsWith('0')) {
                    return 'Please enter a valid WhatsApp number';
                  }
                  if (value.startsWith('0')) {
                    if (value.length != 10) {
                      return 'Please enter a valid WhatsApp number';
                    }
                  } else {
                    if (value.length != 12) {
                      return 'Please enter a valid WhatsApp number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              Text(
                'Board 1',
                style: kFormTitleTextStyle.copyWith(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              //  CustomFormField for board colour
              CustomFormField(
                labelText: 'Board Colour',
                keyText: 'boardColour',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the colour of the board';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              //  CustomFormField for quantity
              CustomFormField(
                labelText: 'Quantity',
                keyText: 'quantity',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              //  CustomFormField for length
              CustomFormField(
                labelText: 'Length',
                keyText: 'length',
                keyboardType: TextInputType.number,
                suffixText: 'cm',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the length';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              //  CustomFormField for width
              CustomFormField(
                labelText: 'Width',
                keyText: 'width',
                keyboardType: TextInputType.number,
                suffixText: 'cm',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the width';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              //  CustomFormField for finish, maxlines = 2
              CustomFormField(
                labelText: 'Finish Details',
                keyText: 'finish',
                maxLines: 2,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the finish details';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 48.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.value.currentState!.validate()) {
                      formKey.value.currentState!.reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessPage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Submit Cutting List',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
              ),
              const SizedBox(height: 48.0),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle kFormTitleTextStyle = GoogleFonts.raleway(
  fontSize: 26,
  color: Colors.black87,
  fontWeight: FontWeight.w600,
);

// SuccessPage
class SuccessPage extends HookConsumerWidget {
  const SuccessPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pine Timber',
              style: kFormTitleTextStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.park,
              color: Colors.white,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100.0,
              ),
              Text(
                'Success!',
                style: kFormTitleTextStyle.copyWith(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              Text(
                'Your cutting list has been submitted successfully',
                style: kFormTitleTextStyle.copyWith(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Add Another List',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
