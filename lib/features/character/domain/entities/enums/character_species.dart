enum CharacterSpecies {
  human,
  alien,
  humanoid,
  poopybutthole,
  mythologicalCreature,
  animal,
  robot,
  cronenberg,
  disease,
  unknown;

  static CharacterSpecies fromString(String value) {
    return switch (value.toLowerCase()) {
      'human' => CharacterSpecies.human,
      'alien' => CharacterSpecies.alien,
      'humanoid' => CharacterSpecies.humanoid,
      'poopybutthole' => CharacterSpecies.poopybutthole,
      'mythological creature' => CharacterSpecies.mythologicalCreature,
      'animal' => CharacterSpecies.animal,
      'robot' => CharacterSpecies.robot,
      'cronenberg' => CharacterSpecies.cronenberg,
      'disease' => CharacterSpecies.disease,
      _ => CharacterSpecies.unknown,
    };
  }

  @override
  String toString() {
    return switch (this) {
      CharacterSpecies.human => 'Human',
      CharacterSpecies.alien => 'Alien',
      CharacterSpecies.humanoid => 'Humanoid',
      CharacterSpecies.poopybutthole => 'Poopybutthole',
      CharacterSpecies.mythologicalCreature => 'Mythological Creature',
      CharacterSpecies.animal => 'Animal',
      CharacterSpecies.robot => 'Robot',
      CharacterSpecies.cronenberg => 'Cronenberg',
      CharacterSpecies.disease => 'Disease',
      CharacterSpecies.unknown => 'Unknown',
    };
  }
}
