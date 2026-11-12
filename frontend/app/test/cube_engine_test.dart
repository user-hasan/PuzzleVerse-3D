import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:puzzleverse_3d/cube_engine.dart';

void main() {
  group('CubeEngine', () {
    test('starts solved with exactly 54 stickers', () {
      final cube = CubeEngine();
      expect(cube.isSolved, isTrue);
      expect(cube.stickerCount, 54);
    });

    test('a face turn changes state and its inverse restores it', () {
      final cube = CubeEngine();
      final move = const CubeMove('R');
      cube.turn(move);
      expect(cube.isSolved, isFalse);
      cube.turn(move.inverse());
      expect(cube.isSolved, isTrue);
    });

    test('four quarter turns of every face restore the solved state', () {
      for (final face in ['R', 'L', 'U', 'D', 'F', 'B']) {
        final cube = CubeEngine();
        for (var i = 0; i < 4; i++) {
          cube.turn(CubeMove(face));
        }
        expect(
          cube.isSolved,
          isTrue,
          reason: '$face should cycle back after four turns',
        );
      }
    });

    test('a seeded scramble is reversible', () {
      final cube = CubeEngine();
      final moves = cube.scramble(length: 24, random: Random(7));
      expect(cube.isSolved, isFalse);
      for (final move in moves.reversed) {
        cube.turn(move.inverse());
      }
      expect(cube.isSolved, isTrue);
    });

    test('copy is independent from the source cube', () {
      final original = CubeEngine();
      final copy = original.copy()..turn(const CubeMove('F'));
      expect(original.isSolved, isTrue);
      expect(copy.isSolved, isFalse);
    });
  });
}
