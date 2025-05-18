class CharacterMetadata {
  String character;
  int startingIndex;
  int endingIndex;

  CharacterMetadata({
    required this.character,
    required this.startingIndex,
    required this.endingIndex,
  }) : assert(character.length == 1, 'Character length must be 1'),
       assert(
         startingIndex >= 0,
         'Starting index must be greater than or equal to 0',
       ),
       assert(
         endingIndex >= startingIndex,
         'Ending index must be greater than or equal to starting index',
       );
}
