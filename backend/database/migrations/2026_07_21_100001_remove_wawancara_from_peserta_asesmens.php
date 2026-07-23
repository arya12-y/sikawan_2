<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('peserta_asesmens', function (Blueprint $table) {
            $table->dropColumn(['wawancara_catatan', 'wawancara_at']);
        });
    }

    public function down(): void
    {
        Schema::table('peserta_asesmens', function (Blueprint $table) {
            $table->text('wawancara_catatan')->nullable();
            $table->timestamp('wawancara_at')->nullable();
        });
    }
};
