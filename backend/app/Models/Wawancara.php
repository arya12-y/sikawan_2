<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Wawancara extends Model
{
    protected $fillable = [
        'peserta_asesmen_id', 'penguji_id',
        'waktu_mulai', 'waktu_selesai', 'durasi_menit', 'metode',
        'catatan_jadwal',
        'nilai_pemahaman', 'nilai_komunikasi', 'nilai_penerapan', 'nilai_sikap',
        'catatan_wawancara', 'rekomendasi', 'status',
    ];

    protected function casts(): array
    {
        return [
            'waktu_mulai' => 'datetime',
            'waktu_selesai' => 'datetime',
            'durasi_menit' => 'integer',
            'nilai_pemahaman' => 'integer',
            'nilai_komunikasi' => 'integer',
            'nilai_penerapan' => 'integer',
            'nilai_sikap' => 'integer',
        ];
    }

    public function pesertaAsesmen(): BelongsTo
    {
        return $this->belongsTo(PesertaAsesmen::class);
    }

    public function penguji(): BelongsTo
    {
        return $this->belongsTo(User::class, 'penguji_id');
    }
}
