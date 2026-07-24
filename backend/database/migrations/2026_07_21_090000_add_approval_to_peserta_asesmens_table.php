<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('peserta_asesmens', function (Blueprint $table) {
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->text('catatan_approve')->nullable();
            $table->text('wawancara_catatan')->nullable();
            $table->timestamp('wawancara_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('peserta_asesmens', function (Blueprint $table) {
            $table->dropForeign(['approved_by']);
            $table->dropColumn(['approved_by', 'approved_at', 'catatan_approve', 'wawancara_catatan', 'wawancara_at']);
        });
    }
};
