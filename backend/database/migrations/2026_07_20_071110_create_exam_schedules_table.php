<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('exam_schedules', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->dateTime('pretest_start');
            $table->dateTime('pretest_end');
            $table->dateTime('learning_start');
            $table->dateTime('learning_end');
            $table->dateTime('exam_start');
            $table->dateTime('exam_end');
            $table->json('kompetensi_ids')->nullable();
            $table->integer('pretest_jumlah_per_kompetensi')->default(5);
            $table->boolean('is_active')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('exam_schedules');
    }
};
