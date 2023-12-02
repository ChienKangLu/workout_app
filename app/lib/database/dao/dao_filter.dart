abstract class DaoFilter {
  String? toWhereClause();

  @override
  String toString() {
    return toWhereClause() ?? "null";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DaoFilter &&
            runtimeType == other.runtimeType &&
            toWhereClause() == other.toWhereClause();
  }

  @override
  int get hashCode => toWhereClause().hashCode;
}
