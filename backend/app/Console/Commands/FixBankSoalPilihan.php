<?php

namespace App\Console\Commands;

use App\Models\BankSoal;
use Illuminate\Console\Command;

class FixBankSoalPilihan extends Command
{
    protected $signature = 'fix:bank-soal-pilihan';
    protected $description = 'Fix double-encoded JSON pilihan on bank_soals table';

    public function handle(): int
    {
        $soals = BankSoal::where('jenis', 'pilihan_ganda')->whereNotNull('pilihan')->get();

        $fixed = 0;
        foreach ($soals as $soal) {
            $pilihan = $soal->pilihan;

            if (!is_string($pilihan)) continue;

            $decoded = json_decode($pilihan, true);

            if (is_array($decoded)) {
                $soal->pilihan = $decoded;
                $soal->saveQuietly();
                $fixed++;
                $this->info("Fixed soal ID: {$soal->id}");
            }
        }

        $this->info("Selesai. Total diperbaiki: {$fixed}");

        return static::SUCCESS;
    }
}
