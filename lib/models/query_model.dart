buildQuery(String firstCurrency, String action, String secondCurrency) {
  return 'TP.DK.$firstCurrency.$action.$secondCurrency';
}

buildCodeField(String firstCurrency, String action, String secondCurrency) {
  return 'TP_DK_$firstCurrency\_$action\_$secondCurrency';
}

buildSQLCodeField(
    String firstCurrency,
    String action,
    String secondCurrency,
    String frequency,
    String formulas,
    String aggregationType,
    String startDate,
    String endDate) {
  return 'TP_DK_$firstCurrency\_$action\_$secondCurrency\_$frequency\_$formulas\_$aggregationType\_$startDate\_$endDate';
}

parseSQLCodeField(String code) {}
