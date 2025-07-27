import 'dart:convert';

class PublicKey {
  String? publicKey;

  PublicKey({this.publicKey});

  @override
  String toString() => 'PublicKey(publicKey: $publicKey)';

  factory PublicKey.fromMap(Map<String, dynamic> data) => PublicKey(
        publicKey: data['publicKey'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'publicKey': publicKey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PublicKey].
  factory PublicKey.fromJson(Map<String, dynamic> json) {
    return PublicKey(publicKey: json["publicKey"]);
  }

  /// `dart:convert`
  ///
  /// Converts [PublicKey] to a JSON string.
  String toJson() => json.encode(toMap());

  PublicKey copyWith({
    String? publicKey,
  }) {
    return PublicKey(
      publicKey: publicKey ?? this.publicKey,
    );
  }
}
