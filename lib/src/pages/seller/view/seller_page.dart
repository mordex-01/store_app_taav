import 'dart:convert';
import 'dart:typed_data';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/generated/locales.g.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';
import 'package:store_app_taav/src/pages/seller/view/my_product_box.dart';
import 'package:store_app_taav/src/pages/seller/view/selected_color_view_model.dart';

class SellerPage extends GetView<SellerController> {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() =>
          controller.isFloatingActionButtonLoading.value
              ? const CircularProgressIndicator()
              : _addActionButton()),
      appBar: _appBar(),
      body: _body(),
    );
  }

  PopupMenuEntry<dynamic> _filterPopUpMenuItemButton(BuildContext context) =>
      PopupMenuItem(
        value: "item2",
        child: Row(
          children: [
            const Icon(Icons.filter_list_rounded),
            Text(LocaleKeys.filter.tr),
          ],
        ),
        onTap: () {
          if (!controller.isFilterButtonPressed.value) {
            //set min max price on filter init
            controller.filteringPriceStartValue.value =
                controller.productsPriceList.first;
            controller.filteringPriceEndValue.value =
                controller.productsPriceList.last;
          }
          ////////////////////////////////////////
          var rangeValue = Rx(RangeValues(
            controller.filteringPriceStartValue.value,
            controller.filteringPriceEndValue.value,
          ));
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(LocaleKeys.filterProducts.tr),
              content: Column(
                children: [
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width + 50,
                  ),
                  Text(
                    LocaleKeys.setPriceRange.tr,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Obx(
                    () => RangeSlider(
                      values: rangeValue.value,

                      onChangeEnd: (value) {
                        controller.filteringPriceStartValue.value = value.start;
                        controller.filteringPriceEndValue.value = value.end;
                      },
                      onChanged: (value) {
                        rangeValue.value = value;
                      },
                      min: controller.productsPriceList.first,
                      max: controller.productsPriceList.last,
                      // labels: RangeLabels(
                      //     "${controller.selectedRange.value.start}",
                      //     "${controller.selectedRange.value.end}"),
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${LocaleKeys.min.tr} ${rangeValue.value.start.toInt()}"),
                        Text(
                            "${LocaleKeys.max.tr} ${rangeValue.value.end.toInt()}")
                      ],
                    ),
                  ),
                  const Divider(),
                  _filterSectionColorTextAndAddButton(context: context),
                  _filterSectionColorsListView(context: context),
                  const Divider(),
                  Text(
                    LocaleKeys.setTagsToFilter.tr,
                    style: const TextStyle(fontSize: 12),
                  ),
                  _filterSectionTagsListView(),
                  const Expanded(child: SizedBox()),
                  _filterButton(
                    text: LocaleKeys.filter.tr,
                    onPressed: () {
                      controller.onFilterButtonPressed(context);
                    },
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  _filterButton(
                    text: LocaleKeys.clearAll.tr,
                    onPressed: () {
                      controller.onClearAllFilterButtonPressed(
                          context: context);
                    },
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  _filterButton(
                    text: LocaleKeys.close.tr,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
  Widget _filterSectionTagsListView() => SizedBox(
        width: double.maxFinite,
        height: 100,
        child: ListView(
          children: [
            Wrap(
              spacing: 5,
              children: List.generate(
                controller.productsTagsList.length,
                (index) => filterSectionTagChips(index: index),
              ),
            ),
          ],
        ),
      );
  Widget _filterSectionColorsListView({required BuildContext context}) =>
      SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 100,
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.filteringDialogSelectedColorList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => dialogSelectedColors(
              color: controller.filteringDialogSelectedColorList[index].color,
              isEnabled:
                  controller.filteringDialogSelectedColorList[index].isEnabled!,
              onRemovePressed: () {
                controller.filteringDialogSelectedColorList.removeAt(index);
              },
            ),
          ),
        ),
      );
  Widget _filterSectionColorTextAndAddButton({required BuildContext context}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.setColorsToFilter.tr,
            style: const TextStyle(fontSize: 12),
          ),
          IconButton(
            onPressed: () {
              if (controller.filteringDialogSelectedColorList.length == 5) {
                return;
              }
              controller.pickColor(
                context: context,
                buildColorPicker: _buildColorPicker(
                  onColorChangeStart: (p0) {
                    controller.isAnyColorSelected.value = false;
                  },
                  onColorChangeEnd: (value) {
                    controller.dialogLastColorSelected.value = value;
                  },
                ),
                onSelectPressed: () {
                  if (!controller.isAnyColorSelected.value) {
                    controller.filteringDialogSelectedColorList.add(
                      SelectedColorViewModel(
                        color: controller.dialogLastColorSelected.value,
                        isEnabled: true,
                      ),
                    );
                    controller.isAnyColorSelected.value = true;
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      );
  Widget filterSectionTagChips({required int index}) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            controller.productsTagsList[index].isTagCheck =
                !controller.productsTagsList[index].isTagCheck;
            //Using App Update ---------------------
            Get.appUpdate();
          },
          child: Chip(
            avatar: controller.productsTagsList[index].isTagCheck
                ? const Icon(Icons.check_box_outlined)
                : const Icon(Icons.check_box_outline_blank_rounded),
            label: Text(
              controller.productsTagsList[index].tagLable,
            ),
          ),
        ),
      );

  Widget dialogSelectedColors({
    required Color? color,
    required bool isEnabled,
    required void Function()? onRemovePressed,
  }) =>
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0, right: 20),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            width: 30,
            height: 30,
          ),
          isEnabled
              ? Positioned(
                  top: 0,
                  right: 0.5,
                  child: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 15,
                    ),
                  ),
                )
              : Positioned(child: Container())
        ],
      );
  Widget _filterButton(
          {required String text, required void Function()? onPressed}) =>
      ElevatedButton(
        style: const ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(200, 50)),
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
            foregroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      );

  Widget _productBox(
          {required int index, required void Function()? onEditTap}) =>
      MyProductBox(
        itemCount: int.parse(controller.productsList[index].count),
        tagItemCount: controller.productsList[index].tag.length,
        index: index,
        id: controller.productsList[index].id,
        product: controller.productsList[index],
        image: controller.productsList[index].image != null &&
                controller.productsList[index].image!.isNotEmpty
            ? Image.memory(
                Uint8List.fromList(
                    base64Decode(controller.productsList[index].image!)),
                fit: BoxFit.cover,
              )
            : Image.asset("assets/no-image-icon.png"),
        onEditTap: onEditTap,
      );
  Widget _buildColorPicker(
          {required void Function(Color)? onColorChangeEnd,
          required void Function(Color)? onColorChangeStart}) =>
      ColorPicker(
        onColorChangeStart: onColorChangeStart,
        enableOpacity: false,
        enableShadesSelection: false,
        enableTonalPalette: false,
        enableTooltips: false,
        onColorChanged: (value) {},
        onColorChangeEnd: onColorChangeEnd,
      );
  Widget _body() => Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.getProducts(),
          child: ListView.builder(
            itemCount: controller.productsList.length,
            itemBuilder: (context, index) => Obx(
              () {
                return _productBox(
                  index: index,
                  onEditTap: () {
                    controller.onEditButtonTapped(index: index);
                  },
                );
              },
            ),
          ),
        ),
      );
  PreferredSizeWidget? _appBar() => AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PopupMenuButton(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                //fill that later
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    if (!controller.isLanguage.value) {
                      Get.updateLocale(const Locale("fa", "IR"));
                      controller.isLanguage.value =
                          !controller.isLanguage.value;
                    } else {
                      Get.updateLocale(const Locale("en", "US"));
                      controller.isLanguage.value =
                          !controller.isLanguage.value;
                    }
                  },
                  value: "item1",
                  child: Row(
                    children: [
                      const Icon(Icons.language),
                      Text(LocaleKeys.changeLanguage.tr),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.refresh),
                      Text(LocaleKeys.refreshList.tr),
                    ],
                  ),
                  onTap: () {
                    controller.onPopUpMenuRefreshTapped();
                  },
                ),
                _filterPopUpMenuItemButton(context),
                PopupMenuItem(
                  value: "item3",
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      Text(LocaleKeys.logOut.tr),
                    ],
                  ),
                  onTap: () {
                    controller.onBackTapped();
                  },
                ),
              ],
            ),
          ),
        ],
        title: TextField(
          onChanged: (value) {
            controller.onSearchTextChanged(value);
          },
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
        ),
      );
  Widget _addActionButton() => InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: () {
          controller.onAddButtonTapped();
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          width: 65,
          height: 65,
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      );
}
