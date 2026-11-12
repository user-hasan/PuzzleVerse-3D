import 'dart:math';

/// Integer vector used for cubie coordinates and sticker normals.
class Vec3i {
  const Vec3i(this.x, this.y, this.z);

  final int x;
  final int y;
  final int z;

  Vec3i rotate(String axis, int direction) {
    switch (axis) {
      case 'x':
        return direction > 0 ? Vec3i(x, -z, y) : Vec3i(x, z, -y);
      case 'y':
        return direction > 0 ? Vec3i(z, y, -x) : Vec3i(-z, y, x);
      default:
        return direction > 0 ? Vec3i(-y, x, z) : Vec3i(y, -x, z);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Vec3i && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => Object.hash(x, y, z);
}

class Cubie {
  Cubie(this.x, this.y, this.z, this.stickers);

  int x;
  int y;
  int z;
  Map<Vec3i, String> stickers;

  Cubie copy() => Cubie(x, y, z, Map<Vec3i, String>.of(stickers));
}

/// A face turn. `clockwise` means clockwise when looking directly at that face.
class CubeMove {
  const CubeMove(this.face, {this.clockwise = true});

  final String face;
  final bool clockwise;

  CubeMove inverse() => CubeMove(face, clockwise: !clockwise);

  String get notation => '$face${clockwise ? '' : "'"}';
}

class CubeEngine {
  CubeEngine() : cubies = _solvedCubies();

  CubeEngine._(this.cubies);

  List<Cubie> cubies;

  static const faceNormals = <String, Vec3i>{
    'R': Vec3i(1, 0, 0),
    'L': Vec3i(-1, 0, 0),
    'U': Vec3i(0, 1, 0),
    'D': Vec3i(0, -1, 0),
    'F': Vec3i(0, 0, 1),
    'B': Vec3i(0, 0, -1),
  };

  static List<Cubie> _solvedCubies() {
    final result = <Cubie>[];
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        for (var z = -1; z <= 1; z++) {
          final stickers = <Vec3i, String>{};
          if (x == 1) stickers[faceNormals['R']!] = 'R';
          if (x == -1) stickers[faceNormals['L']!] = 'L';
          if (y == 1) stickers[faceNormals['U']!] = 'U';
          if (y == -1) stickers[faceNormals['D']!] = 'D';
          if (z == 1) stickers[faceNormals['F']!] = 'F';
          if (z == -1) stickers[faceNormals['B']!] = 'B';
          result.add(Cubie(x, y, z, stickers));
        }
      }
    }
    return result;
  }

  CubeEngine copy() =>
      CubeEngine._(cubies.map((cubie) => cubie.copy()).toList());

  void reset() => cubies = _solvedCubies();

  void turn(CubeMove move) {
    final normal = faceNormals[move.face];
    if (normal == null) throw ArgumentError.value(move.face, 'face');
    final axis = normal.x != 0 ? 'x' : (normal.y != 0 ? 'y' : 'z');
    final layer = axis == 'x' ? normal.x : (axis == 'y' ? normal.y : normal.z);
    final direction = move.clockwise ? -layer : layer;

    for (final cubie in cubies) {
      final coordinate = axis == 'x'
          ? cubie.x
          : (axis == 'y' ? cubie.y : cubie.z);
      if (coordinate != layer) continue;
      final position = Vec3i(cubie.x, cubie.y, cubie.z).rotate(axis, direction);
      cubie.x = position.x;
      cubie.y = position.y;
      cubie.z = position.z;
      cubie.stickers = {
        for (final entry in cubie.stickers.entries)
          entry.key.rotate(axis, direction): entry.value,
      };
    }
  }

  bool get isSolved {
    for (final cubie in cubies) {
      for (final sticker in cubie.stickers.entries) {
        if (faceNormals[sticker.value] != sticker.key) return false;
      }
    }
    return true;
  }

  int get stickerCount =>
      cubies.fold(0, (sum, cubie) => sum + cubie.stickers.length);

  List<CubeMove> scramble({int length = 20, Random? random}) {
    final rng = random ?? Random();
    const faces = ['R', 'L', 'U', 'D', 'F', 'B'];
    final result = <CubeMove>[];
    String? previousFace;
    while (result.length < length) {
      final face = faces[rng.nextInt(faces.length)];
      if (face == previousFace) continue;
      result.add(CubeMove(face, clockwise: rng.nextBool()));
      previousFace = face;
    }
    for (final move in result) {
      turn(move);
    }
    return result;
  }
}
