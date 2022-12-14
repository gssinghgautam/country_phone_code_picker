import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:country_phone_code_picker/constants/country_flag_image.dart';
import 'package:country_phone_code_picker/controller/search_controller.dart';
import 'package:country_phone_code_picker/controller/country_controller.dart';

// ignore: must_be_immutable
class CountryPhoneCodePickerModalSheet extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  CountryPhoneCodePickerModalSheet({
    required this.searchSheetBackgroundWidget,
    required this.searchSheetBackground,
    required this.searchBarLeadingIcon,
    required this.searchBarHintText,
    required this.searchBarHintStyle,
    required this.countryTextStyle,
    required this.searchBarLabelText,
    required this.searchBarLabelStyle,
    required this.searchBarHelperText,
    required this.searchBarHelperStyle,
    required this.searchBarPrefixText,
    required this.searchBarPrefixStyle,
    required this.searchBarPrefixIcon,
    required this.searchBarContentPadding,
    required this.border,
    required this.errorBorder,
    required this.focusedBorder,
    required this.disabledBorder,
    required this.focusedErrorBorder,
    required this.enabledBorder,
    required this.searchBarCursorColor,
    required this.searchBarCursorHeight,
    required this.searchBarCursorWidth,
    required this.style,
    required this.searchBarInitialValue,
    required this.keyboardType,
    required this.showCursor,
  });

  TextEditingController? searchBarInput;

  // Background widget
  Widget searchSheetBackgroundWidget;
  //color of the background of the sheet
  Color searchSheetBackground;

  //leading icon in the appbar that exits the modal sheet page
  Icon searchBarLeadingIcon;

  //hint text for search bar
  String? searchBarHintText;

  //styling for hint text
  TextStyle searchBarHintStyle;

  TextStyle countryTextStyle;

  //label text for search bar
  String? searchBarLabelText;

  //styling for label text
  TextStyle searchBarLabelStyle;

  //helper text for search bar
  String? searchBarHelperText;

  //styling for helper text
  TextStyle searchBarHelperStyle;

  //prefix text for search bar
  String? searchBarPrefixText;

  //styling for prefix text
  TextStyle searchBarPrefixStyle;

  //prefix icon for search bar
  Icon searchBarPrefixIcon;

  //padding inside the search bar text field
  EdgeInsetsGeometry searchBarContentPadding;

  //border of search bar text field
  InputBorder border;

  //error border for search bar text field
  InputBorder errorBorder;

  //focused border for search bar text field
  InputBorder focusedBorder;

  //disabled border for search bar text field
  InputBorder disabledBorder;

  //focused error border for search bar text field
  InputBorder focusedErrorBorder;

  //enabled border for search bar text field
  InputBorder enabledBorder;

  //color of cursor of search bar text field
  Color searchBarCursorColor;

  //height of cursor of search bar text field
  double searchBarCursorHeight;

  //width of cursor of search bar text field
  double searchBarCursorWidth;

  //text style of the input inside search bar text field
  TextStyle style;

  //initial value of the input in search bar text field
  String searchBarInitialValue;

  //keyboard type of search bar text field
  TextInputType keyboardType;

  //show cursor if the value is set to true
  bool showCursor;

  @override
  Widget build(BuildContext context) {
    searchBarInput = TextEditingController(text: searchBarInitialValue);
    SearchController searchController = Get.put(SearchController());
    CountryController countryController = Get.find<CountryController>();
    return Stack(
      children: [
        searchSheetBackgroundWidget,
        Scaffold(
          backgroundColor: searchSheetBackground,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: searchSheetBackground,
            elevation: 1.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: searchBarLeadingIcon,
            ),
            title: Container(
              alignment: Alignment.center,
              height: 30.0,
              child: TextField(
                controller: searchBarInput,
                onChanged: (query) {
                  searchController.updateQueryList(query);
                },
                decoration: InputDecoration(
                  hintText: searchBarHintText,
                  hintStyle: searchBarHintStyle,
                  labelText: searchBarLabelText,
                  labelStyle: searchBarLabelStyle,
                  helperText: searchBarHelperText,
                  helperStyle: searchBarHelperStyle,
                  prefixText: searchBarPrefixText,
                  prefixStyle: searchBarPrefixStyle,
                  suffix: IconButton(
                    onPressed: () {
                      searchBarInput!.clear();
                      searchController.updateQueryList('');
                    },
                    icon: const Icon(Icons.cancel_rounded, color: Colors.black),
                  ),
                  contentPadding: searchBarContentPadding,
                  border: border,
                  errorBorder: errorBorder,
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  disabledBorder: disabledBorder,
                  focusedErrorBorder: focusedErrorBorder,
                ),
                cursorColor: searchBarCursorColor,
                cursorHeight: searchBarCursorHeight,
                cursorWidth: searchBarCursorWidth,
                style: style,
                keyboardType: keyboardType,
                showCursor: showCursor,
              ),
            ),
          ),
          body: GetBuilder<SearchController>(
            builder: (controller) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: controller.filteredCountries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onTap: () {
                      countryController.updateSelectedCountry(
                          controller.filteredCountries[index]);
                      searchController.updateQueryList('');
                      Navigator.pop(context);
                    },
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(countryFlagApi +
                              controller.filteredCountries[index].code),
                        ),
                      ),
                    ),
                    title: Text(
                      controller.filteredCountries[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: countryTextStyle,
                    ),
                    trailing: Text(
                      controller.filteredCountries[index].phoneCode,
                      style: countryTextStyle,
                    ),
                  );
                },
                separatorBuilder: (context, index){
                  return const Divider(color: Color(0xFF9FA7C4), height: 1.0, thickness: 0.5,);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
