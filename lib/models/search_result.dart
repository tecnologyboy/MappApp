class SearchResult {
  final bool cancel;
  final bool manual;

  SearchResult({
    required this.cancel, 
    this.manual = false
    });

    //TODO Description, position, others...

    @override
  String toString() {
    // TODO: implement toString
    return '{Cancel: $cancel, Manuel: $manual}';
  }  

}
