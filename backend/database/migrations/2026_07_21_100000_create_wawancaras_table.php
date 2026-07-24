<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('wawancaras', function (Blueprint $table) {
            $table->id();
            $table->foreignId('peserta_asesmen_id')->constrained('peserta_asesmens')->cascadeOnDelete();
            $table->foreignId('penguji_id')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('waktu_mulai')->nullable();
            $table->timestamp('waktu_selesai')->nullable();
            $table->integer('durasi_menit')->default(30);
            $table->string('metode', 20)->nullable();
            $table->text('catatan_jadwal')->nullable();
            $table->tinyInteger('nilai_pemahaman')->nullable();
            $table->tinyInteger('nilai_komunikasi')->nullable();
            $table->tinyInteger('nilai_penerapan')->nullable();
            $table->tinyInteger('nilai_sikap')->nullable();
            $table->text('catatan_wawancara')->nullable();
            $table->enum('rekomendasi', ['lulus', 'tidak_lulus'])->nullable();
            $table->enum('status', ['belum', 'terjadwal', 'selesai'])->default('belum');
            $table->timestamps();

            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('wawancaras');
    }
};
