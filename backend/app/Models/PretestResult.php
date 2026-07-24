<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PretestResult extends Model
{
    protected $fillable = [
        'user_id', 'kompetensi_id', 'sesi_id',
        'nilai', 'jawaban', 'completed_at',
    ];

    protected function casts(): array
    {
        return [
            'nilai' => 'decimal:2',
            'jawaban' => 'array',
            'completed_at' => 'datetime',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function kompetensi(): BelongsTo
    {
        return $this->belongsTo(Kompetensi::class);
    }
}
