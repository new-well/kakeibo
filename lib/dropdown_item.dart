enum HistoryCategory {
  food,
  daylyUsed,
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

extension HistoryCategoryExtension on HistoryCategory {
  String get itemName {
    switch (this) {
      case HistoryCategory.food:
        return '食費';
      case HistoryCategory.daylyUsed:
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
