<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pretest_results', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('kompetensi_id')->constrained('kompetensis')->cascadeOnDelete();
            $table->string('sesi_id');
            $table->decimal('nilai', 5, 2)->default(0);
            $table->json('jawaban')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'sesi_id']);
            $table->index(['user_id', 'kompetensi_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pretest_results');
    }
};
