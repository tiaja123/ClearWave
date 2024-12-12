import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart'; // Pastikan jalur file ini sesuai dengan struktur proyek Anda.

void main() {
  testWidgets('Navigasi dan interaksi tombol tambah', (WidgetTester tester) async {
    // Build aplikasi dan trigger satu frame.
    await tester.pumpWidget(ClearWaveApp());

    // Verifikasi bahwa halaman awal memiliki teks 'Search Your Water'.
    expect(find.text('Search Your Water'), findsOneWidget);

    // Verifikasi keberadaan ikon tambah pada salah satu produk.
    expect(find.byIcon(Icons.add), findsWidgets);

    // Tap salah satu ikon tambah dan trigger satu frame.
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();

    // Tidak ada logika tambahan saat tombol tambah ditekan, 
    // sehingga kita hanya memverifikasi bahwa aplikasi tetap berjalan.
    expect(find.byIcon(Icons.add), findsWidgets);

    // Navigasikan ke halaman Category menggunakan bottom navigation bar.
    await tester.tap(find.byIcon(Icons.category));
    await tester.pumpAndSettle();

    // Verifikasi bahwa aplikasi berpindah halaman (tidak ada elemen halaman Home).
    expect(find.text('Search Your Water'), findsNothing);

    // Navigasikan kembali ke halaman Home menggunakan bottom navigation bar.
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // Verifikasi bahwa halaman Home muncul kembali.
    expect(find.text('Search Your Water'), findsOneWidget);
  });
}