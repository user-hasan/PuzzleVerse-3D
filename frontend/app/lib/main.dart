import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import 'cube_engine.dart';

const _ink = Color(0xFF17223B);
const _muted = Color(0xFF71809A);
const _purple = Color(0xFF6C5CE7);
const _lavender = Color(0xFFEEEAFE);
const _surface = Color(0xFFFFFFFF);
const _canvas = Color(0xFFF5F7FB);

void main() => runApp(const PuzzleVerseApp());

class PuzzleVerseApp extends StatelessWidget {
  const PuzzleVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    const scheme = ColorScheme.light(
      primary: _purple,
      onPrimary: Colors.white,
      secondary: Color(0xFF19A995),
      surface: _surface,
      onSurface: _ink,
    );
    return MaterialApp(
      title: 'PuzzleVerse-3D',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: _canvas,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: CubePracticePage(),
      ),
    );
  }
}

class CubePracticePage extends StatefulWidget {
  const CubePracticePage({super.key});
  @override
  State<CubePracticePage> createState() => _CubePracticePageState();
}

class _CubePracticePageState extends State<CubePracticePage> {
  CubeEngine _cube = CubeEngine();
  final List<({CubeEngine cube, int moveCount})> _undo = [];
  double _yaw = 0.56;
  double _pitch = 0.42;
  int _moves = 0;
  final _random = math.Random();

  void _turn(CubeMove move) => setState(() {
    _undo.add((cube: _cube.copy(), moveCount: _moves));
    _cube = _cube.copy()..turn(move);
    _moves++;
  });

  void _undoMove() {
    if (_undo.isEmpty) return;
    setState(() {
      final previous = _undo.removeLast();
      _cube = previous.cube;
      _moves = previous.moveCount;
    });
  }

  void _reset() => setState(() {
    _cube = CubeEngine();
    _undo.clear();
    _moves = 0;
    _yaw = 0.56;
    _pitch = 0.42;
  });

  void _scramble() => setState(() {
    _undo.add((cube: _cube.copy(), moveCount: _moves));
    _cube = _cube.copy();
    _moves += _cube.scramble(random: _random).length;
  });

  Future<void> _showGuide() => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: _surface,
    builder: (context) => const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 8, 24, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'طريقة التحكم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _ink,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'اسحب على المكعب لتدوير زاوية الرؤية. استخدم أزرار R وL وU وD وF وB لتدوير وجه من أوجه المكعب.',
              style: TextStyle(height: 1.65, color: _muted),
            ),
            SizedBox(height: 10),
            Text(
              'هذه نسخة تجريبية للعب بالمكعب الافتراضي. المسح بالكاميرا وإيجاد حل تلقائي غير متاحين بعد.',
              style: TextStyle(height: 1.6, color: _muted),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final solved = _cube.isSolved;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _topBar(),
                  const SizedBox(height: 23),
                  const Text(
                    'أهلًا بك في عالم الألغاز',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'حرّك المكعب وتدرّب على استكشافه',
                    style: TextStyle(fontSize: 13, color: _muted),
                  ),
                  const SizedBox(height: 18),
                  _cubeCard(solved),
                  const SizedBox(height: 18),
                  _moveHeader(),
                  const SizedBox(height: 10),
                  _moveButtons(),
                  const SizedBox(height: 14),
                  _sessionControls(),
                  const SizedBox(height: 18),
                  _statusCard(solved),
                  const SizedBox(height: 18),
                  _scopeNotice(),
                  const SizedBox(height: 14),
                  Center(
                    child: TextButton.icon(
                      onPressed: _showGuide,
                      icon: const Icon(Icons.help_outline, size: 18),
                      label: const Text('دليل التحكم والنسخة التجريبية'),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar() => Row(
    children: [
      Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: _lavender,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: const Text(
          'PV',
          style: TextStyle(
            color: _purple,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      const SizedBox(width: 10),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PuzzleVerse',
              style: TextStyle(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'منصة الألغاز ثلاثية الأبعاد',
              style: TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF2D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'نسخة تجريبية ٠.١',
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF94600B),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );

  Widget _cubeCard(bool solved) => Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xFF151F39), Color(0xFF2A3155)],
      ),
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1C26385B),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 16, 17, 0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'مكعب روبيك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _darkPill(
                solved ? 'جاهز للتدريب' : 'قيد اللعب',
                solved ? const Color(0xFF1C786E) : const Color(0xFF554F90),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 276,
          width: double.infinity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) => setState(() {
              _yaw += details.delta.dx * 0.012;
              _pitch = (_pitch - details.delta.dy * 0.009).clamp(-0.25, 1.1);
            }),
            child: CustomPaint(
              painter: CubePainter(_cube, yaw: _yaw, pitch: _pitch),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              const Icon(
                Icons.pan_tool_alt_rounded,
                size: 15,
                color: Color(0xFFC8C9E6),
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'اسحب لتدوير المكعب',
                  style: TextStyle(fontSize: 11, color: Color(0xFFD4D7E8)),
                ),
              ),
              Text(
                '$_moves حركة',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFE0DDFE),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _darkPill(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _moveHeader() => Row(
    children: [
      const Expanded(
        child: Text(
          'حرّك أحد الأوجه',
          style: TextStyle(
            color: _ink,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      TextButton(
        onPressed: _showGuide,
        child: const Text('شرح الرموز', style: TextStyle(fontSize: 11)),
      ),
    ],
  );

  Widget _moveButtons() {
    const moves = [
      ('R', 'يمين'),
      ('L', 'يسار'),
      ('U', 'أعلى'),
      ('D', 'أسفل'),
      ('F', 'أمام'),
      ('B', 'خلف'),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 9,
      children: moves
          .map(
            (move) => SizedBox(
              width: (MediaQuery.sizeOf(context).width - 56) / 3,
              child: OutlinedButton(
                onPressed: () => _turn(CubeMove(move.$1)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: _surface,
                  foregroundColor: _ink,
                  side: const BorderSide(color: Color(0xFFE3E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Column(
                  children: [
                    Text(
                      move.$1,
                      style: const TextStyle(
                        fontSize: 18,
                        color: _purple,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      move.$2,
                      style: const TextStyle(fontSize: 10, color: _muted),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _sessionControls() => Row(
    children: [
      Expanded(
        child: _controlButton(
          Icons.shuffle_rounded,
          'خلط',
          _scramble,
          filled: true,
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _controlButton(
          Icons.undo_rounded,
          'تراجع',
          _undoMove,
          enabled: _undo.isNotEmpty,
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _controlButton(Icons.restart_alt_rounded, 'إعادة', _reset),
      ),
    ],
  );

  Widget _controlButton(
    IconData icon,
    String label,
    VoidCallback onPressed, {
    bool filled = false,
    bool enabled = true,
  }) => OutlinedButton.icon(
    onPressed: enabled ? onPressed : null,
    icon: Icon(icon, size: 17),
    label: Text(
      label,
      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
    ),
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 44),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      backgroundColor: filled ? _purple : _surface,
      foregroundColor: filled ? Colors.white : _ink,
      disabledForegroundColor: const Color(0xFFAFB7C6),
      side: BorderSide(color: filled ? _purple : const Color(0xFFE3E8F0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  Widget _statusCard(bool solved) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: solved ? const Color(0xFFEAF8F4) : const Color(0xFFFFF6E7),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(
          solved ? Icons.check_circle_outline : Icons.lightbulb_outline,
          color: solved ? const Color(0xFF178D7A) : const Color(0xFFAF7612),
          size: 21,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            solved
                ? 'المكعب في الحالة المكتملة. ابدأ التدريب بالخلط أو تدوير أي وجه.'
                : 'تم تدوير المكعب. جرّب إعادة ضبطه أو واصل التدرب على الحركات.',
            style: const TextStyle(color: _ink, fontSize: 11, height: 1.5),
          ),
        ),
      ],
    ),
  );

  Widget _scopeNotice() => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: const Color(0xFFE6EAF1)),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline_rounded, color: _purple, size: 19),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'هذه أول نسخة تشغيلية للمكعب الافتراضي. مسح الكاميرا، الحل التلقائي، الحسابات، وحفظ التقدم ستُضاف بعد تطويرها واختبارها.',
            style: TextStyle(color: _muted, fontSize: 11, height: 1.55),
          ),
        ),
      ],
    ),
  );
}

class _Vec3 {
  const _Vec3(this.x, this.y, this.z);
  final double x, y, z;
  _Vec3 operator +(_Vec3 other) => _Vec3(x + other.x, y + other.y, z + other.z);
  _Vec3 operator *(double scalar) => _Vec3(x * scalar, y * scalar, z * scalar);
  double dot(_Vec3 other) => x * other.x + y * other.y + z * other.z;
}

class _StickerPolygon {
  const _StickerPolygon(this.points, this.depth, this.color);
  final List<Offset> points;
  final double depth;
  final Color color;
}

class CubePainter extends CustomPainter {
  CubePainter(this.cube, {required this.yaw, required this.pitch});
  final CubeEngine cube;
  final double yaw;
  final double pitch;

  static const _faceColors = <String, Color>{
    'R': Color(0xFFE94F4F),
    'L': Color(0xFFF28B38),
    'U': Color(0xFFF8F8F2),
    'D': Color(0xFFFFD34E),
    'F': Color(0xFF39B879),
    'B': Color(0xFF4A91E2),
  };

  @override
  void paint(Canvas canvas, Size size) {
    final sinYaw = math.sin(yaw), cosYaw = math.cos(yaw);
    final sinPitch = math.sin(pitch), cosPitch = math.cos(pitch);
    final camera = _Vec3(sinYaw * cosPitch, sinPitch, cosYaw * cosPitch);
    final right = _Vec3(cosYaw, 0, -sinYaw);
    final up = _Vec3(-sinYaw * sinPitch, cosPitch, -cosYaw * sinPitch);
    final scale = math.min(size.width, size.height) * 0.31;
    final center = Offset(size.width / 2, size.height / 2 + 8);
    Offset project(_Vec3 p) =>
        Offset(center.dx + p.dot(right) * scale, center.dy - p.dot(up) * scale);
    final polygons = <_StickerPolygon>[];

    for (final cubie in cube.cubies) {
      final location = _Vec3(
        cubie.x.toDouble(),
        cubie.y.toDouble(),
        cubie.z.toDouble(),
      );
      for (final entry in cubie.stickers.entries) {
        final normal = _Vec3(
          entry.key.x.toDouble(),
          entry.key.y.toDouble(),
          entry.key.z.toDouble(),
        );
        final facing = normal.dot(camera);
        if (facing < -0.001) continue;
        final tangentA = entry.key.x != 0
            ? const _Vec3(0, 0, 1)
            : const _Vec3(1, 0, 0);
        final tangentB = entry.key.y != 0
            ? const _Vec3(0, 0, 1)
            : const _Vec3(0, 1, 0);
        final stickerCenter = location + normal * 0.505;
        const half = 0.455;
        final corners = [
          stickerCenter + tangentA * -half + tangentB * -half,
          stickerCenter + tangentA * half + tangentB * -half,
          stickerCenter + tangentA * half + tangentB * half,
          stickerCenter + tangentA * -half + tangentB * half,
        ];
        final shade = (0.86 + math.max(0, facing) * 0.14).clamp(0.0, 1.0);
        final base = _faceColors[entry.value]!;
        final color = Color.fromARGB(
          (base.a * 255).round().clamp(0, 255),
          (base.r * 255 * shade).round().clamp(0, 255),
          (base.g * 255 * shade).round().clamp(0, 255),
          (base.b * 255 * shade).round().clamp(0, 255),
        );
        polygons.add(
          _StickerPolygon(
            corners.map(project).toList(),
            stickerCenter.dot(camera),
            color,
          ),
        );
      }
    }
    polygons.sort((a, b) => a.depth.compareTo(b.depth));
    canvas.drawOval(
      Rect.fromCenter(
        center: center + const Offset(0, 87),
        width: scale * 3.4,
        height: 24,
      ),
      Paint()
        ..color = const Color(0x44090D1A)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );
    for (final polygon in polygons) {
      final path = Path()
        ..moveTo(polygon.points.first.dx, polygon.points.first.dy);
      for (final point in polygon.points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      path.close();
      canvas.drawPath(
        path,
        Paint()
          ..color = polygon.color
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xCC182037)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.3
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CubePainter oldDelegate) =>
      !identical(cube, oldDelegate.cube) ||
      yaw != oldDelegate.yaw ||
      pitch != oldDelegate.pitch;
}
