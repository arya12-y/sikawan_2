<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('exam_schedules', function (Blueprint $table) {
            $table->datetime('learning_start')->nullable()->change();
            $table->datetime('learning_end')->nullable()->change();
        });
    }

    public function down(): void
    {
        // Not reverting nullable - would require data cleanup
    }
};
