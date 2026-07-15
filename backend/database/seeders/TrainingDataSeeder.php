<?php

namespace Database\Seeders;

use App\Models\MateriProgress;
use App\Models\NilaiKompetensi;
use App\Models\User;
use App\Models\Materi;
use App\Models\Walidata;
use App\Models\Kompetensi;
use Illuminate\Database\Seeder;

class TrainingDataSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::whereHas('walidata')->get();
        $materis = Materi::all();
        $kompetensis = Kompetensi::all();
        $walidatas = Walidata::all();

        if ($users->isEmpty() || $materis->isEmpty()) {
            $this->command->warn('Butuh data User (dengan Walidata) dan Materi terlebih dahulu. Jalankan MasterDataSeeder dulu.');
            return;
        }

        // --- MATERI PROGRESS ---
        $bar = $this->command->getOutput()->createProgressBar($users->count());
        $bar->start();

        foreach ($users as $user) {
            $completedCount = 0;
            foreach ($materis->random(min($materis->count(), rand(1, 5))) as $materi) {
                $isCompleted = (bool) rand(0, 1);
                MateriProgress::updateOrCreate(
                    ['user_id' => $user->id, 'materi_id' => $materi->id],
                    [
                        'progress' => $isCompleted ? 100 : rand(10, 90),
                        'is_completed' => $isCompleted,
                        'completed_at' => $isCompleted ? now()->subDays(rand(0, 30)) : null,
                    ]
                );
                if ($isCompleted) $completedCount++;
            }
            $bar->advance();
        }

        $bar->finish();
        $this->command->newLine();
        $this->command->info('MateriProgress: '.MateriProgress::count().' records created.');

        // --- NILAI KOMPETENSI ---
        if ($kompetensis->isEmpty()) {
            $this->command->warn('Tidak ada data Kompetensi. Lewati NilaiKompetensi.');
            return;
        }

        $bar2 = $this->command->getOutput()->createProgressBar($walidatas->count());
        $bar2->start();

        foreach ($walidatas as $walidata) {
            foreach ($kompetensis->random(min($kompetensis->count(), rand(1, 3))) as $kompetensi) {
                $nilai = round(rand(2000, 9500) / 100, 2);
                NilaiKompetensi::updateOrCreate(
                    ['user_id' => $walidata->user_id, 'kompetensi_id' => $kompetensi->id],
                    [
                        'nilai' => $nilai,
                        'kategori' => 'Seed Data',
                    ]
                );
            }

            // Update walidatas.nilai_kompetensi (rata-rata)
            $avg = NilaiKompetensi::where('user_id', $walidata->user_id)->avg('nilai');
            $walidata->update(['nilai_kompetensi' => round($avg ?? 0, 2)]);

            $bar2->advance();
        }

        $bar2->finish();
        $this->command->newLine();
        $this->command->info('NilaiKompetensi: '.NilaiKompetensi::count().' records created.');
        $this->command->info('Selesai! Data training sudah siap. Buka dashboard untuk melihat grafik.');
    }
}
