import 'dart:io'; 

void main() {
  // List<String> input = File('day21-sample.txt').readAsStringSync().split("\n");
  List<String> input = File('day21.txt').readAsStringSync().split("\n");
  Map<String, int> occurrences = getIngredientOccurences(input);
  Map<String, Set<String>> candidates = getAllergenCandidates(input);
  print("Part 1: " + day21a(occurrences, candidates).toString());
  print("Part 2: " + day21b(candidates));
}

Map<String, int> getIngredientOccurences(List<String> input) {
  Map<String, int> occurrences = {};
  input
    .map((e) => e.replaceFirst(')', '').split(' (contains ').first.split(' '))
    .expand((element) => element)
    .forEach((ingredient) => occurrences.update(ingredient, (value) => ++value, ifAbsent: () => 1));
  return occurrences;
}

Map<String, Set<String>> getAllergenCandidates(List<String> lines) {
  Map<String, Set<String>> candidates = <String, Set<String>>{};
  for (var recipe in lines) {
    var vs = recipe.replaceFirst(')', '').split(' (contains ');
    var ingredients = vs.first.split(' ').toSet();
    var allergens = vs.last.split(', ');

    //further cumulate restriction on ingredient each time it is seen with a particular allergen
    for (var allergen in allergens)
      candidates[allergen] = (candidates[allergen] ?? ingredients).intersection(ingredients);
  }
  return candidates;
}
 
int day21a(Map<String, int> occurrences, Map<String, Set<String>> allergenCands) {
  Map<String, int> nonSuspected = occurrences
  ..removeWhere((k, v) => allergenCands.values.expand((e) => e).toSet().contains(k)); //remove candidates for any allergen
  return nonSuspected
    .values
    .reduce((sum, element) => sum + element); //sum of occurrences
}
 
String day21b(Map<String, Set<String>> allergenCandidates) { 
  List<String> simplified = simplify(allergenCandidates)
    .keys
    .toList()
    ..sort();
  return simplified
    .map((e) => allergenCandidates[e].first)
    .join(',');
}

//iteratively narrow each allergen to one ingredient
Map<String, Set<String>> simplify(Map<String, Set<String>> candidates) {
  var candidatesEq1 = candidates.keys.where((k) => candidates[k].length == 1).toList();
  var candidatesGt1 = candidates.keys.where((k) => candidates[k].length > 1).toList();
  while (candidatesEq1.isNotEmpty) {
    var allergen = candidates[candidatesEq1.removeAt(0)].first; //remove confirmed ingredient as head
    for (var candidate in [...candidatesGt1]) { //for each remaining unconfirmed allergen
      if (candidates[candidate].remove(allergen) && candidates[candidate].length == 1) { //remove from suspicion, if confirmed another add it
        candidatesEq1.add(candidate);
        candidatesGt1.remove(candidate);
      }
    }
  }
  return candidates;
}
