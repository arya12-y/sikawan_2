<?php

namespace App\Helpers;

use App\Models\Notifikasi;

class NotifikasiHelper
{
    public static function send(int $userId, string $judul, string $pesan, string $tipe = 'info', ?string $link = null): Notifikasi
    {
        return Notifikasi::create([
            'user_id' => $userId,
            'judul' => $judul,
            'pesan' => $pesan,
            'tipe' => $tipe,
            'link' => $link,
        ]);
    }
}
