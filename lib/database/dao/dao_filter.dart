abstract class DaoFilter {
  String toWhereClause();

  @override
  String toString() {
    return toWhereClause();
  }
}
