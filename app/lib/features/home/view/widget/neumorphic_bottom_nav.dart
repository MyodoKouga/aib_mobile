import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';

class NeumorphicBottomNav extends ConsumerWidget {
 @override
 Widget build(BuildContext context, WidgetRef ref) {
   final homeState = ref.watch(homeViewModelProvider);

   return NeumorphicContainer(
     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: BottomNavItem.values.map((tab) {
         final isSelected = tab == homeState.currentTab;
         return _buildNavItem(context, tab, isSelected, () {
           ref.read(homeViewModelProvider.notifier).changeTab(tab);
         });
       }).toList(),
     ),
   );
 }

 Widget _buildNavItem(BuildContext context, BottomNavItem item, bool isSelected, VoidCallback onTap) {
   return GestureDetector(
     onTap: onTap,
     child: NeumorphicContainer(
       isPressed: isSelected,
       padding: EdgeInsets.all(12.w),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Icon(
             item.icon,
             color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
           ),
           SizedBox(height: 4.h),
           Text(
             item.label,
             style: TextStyle(
               fontSize: 12.sp,
               color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
             ),
           ),
         ],
       ),
     ),
   );
 }
}