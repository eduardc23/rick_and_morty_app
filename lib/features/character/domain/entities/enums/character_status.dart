enum CharacterStatus {
  alive,
  dead,
  unknown;

  static CharacterStatus fromString(String value) {
    return switch (value.toLowerCase()) {
      'alive' => CharacterStatus.alive,
      'dead' => CharacterStatus.dead,
      _ => CharacterStatus.unknown,
    };
  }

  bool get isAlive => this == CharacterStatus.alive;
  bool get isDead => this == CharacterStatus.dead;
  bool get isUnknown => this == CharacterStatus.unknown;

  @override
  String toString() {
    return switch (this) {
      CharacterStatus.alive => 'Alive',
      CharacterStatus.dead => 'Dead',
      CharacterStatus.unknown => 'Unknown',
    };
  }
}
