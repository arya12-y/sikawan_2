<?php

namespace App\Services;

use App\Models\BankSoal;
use App\Models\Level;
use App\Models\PesertaAsesmen;

class AssessmentService
{
    public function calculateAnswerScore(BankSoal $soal, ?string $jawaban): array
    {
        $jenis = strtolower((string) $soal->jenis);
        
        if (in_array($jenis, ['essay', 'esai'], true)) {
            return ['is_benar' => null, 'nilai' => 0.0];
        }

        $jawaban = trim((string) $jawaban);
        $kunci = trim((string) $soal->jawaban_benar);
        $benar = $jawaban === $kunci;

        // Jika tidak cocok teks, coba cocok berdasarkan huruf (A/B/C/D) ke indeks pilihan
        if (!$benar) {
            $pilihan = is_array($soal->pilihan) ? $soal->pilihan : (json_decode((string) $soal->pilihan, true) ?? []);
            $indeksKunci = array_search($kunci, ['A', 'B', 'C', 'D', 'E'], true);
            $indeksJawab = array_search($jawaban, ['A', 'B', 'C', 'D', 'E'], true);

            if ($indeksKunci !== false && isset($pilihan[$indeksKunci])) {
                $benar = $jawaban === $pilihan[$indeksKunci];
            }

            if (!$benar && $indeksJawab !== false && isset($pilihan[$indeksJawab])) {
                $benar = $kunci === $pilihan[$indeksJawab];
            }
        }

        return ['is_benar' => $benar, 'nilai' => $benar ? (float) $soal->bobot : 0.0];
    }

    public function recalculatePeserta(PesertaAsesmen $peserta): PesertaAsesmen
    {
        $peserta->loadMissing('asesmen.bankSoals', 'jawabanPesertas.bankSoal');
        $totalBobot = (float) $peserta->asesmen?->bankSoals->sum(fn ($soal) => (float) $soal->bobot);
        $totalNilai = (float) $peserta->jawabanPesertas->sum(fn ($jawaban) => (float) ($jawaban->nilai ?? 0));
        $nilai = $totalBobot > 0 ? round(($totalNilai / $totalBobot) * 100) : 0;

        $peserta->update([
            'nilai' => $nilai,
            'lulus' => $nilai >= (float) ($peserta->asesmen?->nilai_lulus ?? 0),
        ]);

        return $peserta->refresh();
    }

    public function determineLevel(float $nilai): ?Level
    {
        return Level::query()->where('nilai_min', '<=', $nilai)->where('nilai_max', '>=', $nilai)->first()
            ?? Level::query()->orderByDesc('id')->first();
    }

    public function kategori(float $nilai): string
    {
        return match (true) {
            $nilai >= 90 => 'Ahli',
            $nilai >= 80 => 'Mahir',
            $nilai >= 70 => 'Terampil',
            $nilai >= 60 => 'Dasar',
            default => 'Pemula',
        };
    }
}
