import 'package:flutter/material.dart';

enum HistoryCategory {
  food,
  dailyUsed,
  hobby,
  entertaiment,
  transportation,
  beauty,
  medical,
  autoMobile,
  education,
  special,
  utility,
  communication,
  housing,
  tax,
  insurance,
  other,
}

extension HistoryCategoryToJapaneseNameExtension on HistoryCategory {
  String get japaneseName {
    switch (this) {
      case HistoryCategory.food:
        return '食費';
      case HistoryCategory.dailyUsed:
        return '日用品';
      case HistoryCategory.hobby:
        return '趣味・娯楽';
      case HistoryCategory.entertaiment:
        return '交際費';
      case HistoryCategory.transportation:
        return '交通費';
      case HistoryCategory.beauty:
        return '衣服・美容';
      case HistoryCategory.medical:
        return '健康・医療';
      case HistoryCategory.autoMobile:
        return '自動車';
      case HistoryCategory.education:
        return '教養・教育';
      case HistoryCategory.special:
        return '特別な支出';
      case HistoryCategory.utility:
        return '水道・光熱費';
      case HistoryCategory.communication:
        return '通信費';
      case HistoryCategory.housing:
        return '住宅';
      case HistoryCategory.tax:
        return '税・社会保障';
      case HistoryCategory.insurance:
        return '保険';
      case HistoryCategory.other:
        return 'その他';
    }
  }
}

extension HistoryCategoryToIconExtension on HistoryCategory {
  IconData get icon {
    switch (this) {
      case HistoryCategory.food:
        return Icons.restaurant;
      case HistoryCategory.dailyUsed:
        return Icons.shopping_basket;
      case HistoryCategory.hobby:
        return Icons.sports_esports;
      case HistoryCategory.entertaiment:
        return Icons.attractions;
      case HistoryCategory.transportation:
        return Icons.directions_bus;
      case HistoryCategory.beauty:
        return Icons.auto_awesome;
      case HistoryCategory.medical:
        return Icons.medical_services;
      case HistoryCategory.autoMobile:
        return Icons.directions_car;
      case HistoryCategory.education:
        return Icons.school;
      case HistoryCategory.special:
        return Icons.try_sms_star;
      case HistoryCategory.utility:
        return Icons.gas_meter;
      case HistoryCategory.communication:
        return Icons.rss_feed;
      case HistoryCategory.housing:
        return Icons.home;
      case HistoryCategory.tax:
        return Icons.savings;
      case HistoryCategory.insurance:
        return Icons.favorite;
      case HistoryCategory.other:
        return Icons.payments;
    }
  }
}
