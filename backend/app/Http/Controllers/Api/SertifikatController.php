<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PesertaAsesmen;
use App\Models\Sertifikat;
use App\Services\AssessmentService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class SertifikatController extends Controller
{
    public function index(Request $request)
    {
        $query = Sertifikat::with('user', 'asesmen', 'kompetensi', 'level')->latest();

        if ($request->user()?->hasRole('Walidata')) {
            $query->where('user_id', $request->user()->id);
        }

        return response()->json($query->paginate((int) $request->query('per_page', 15)));
    }

    public function generate(AssessmentService $service, $pesertaId)
    {
        $peserta = PesertaAsesmen::with('user', 'asesmen.kompetensi', 'asesmen.level')->findOrFail($pesertaId);
        abort_unless($peserta->lulus, 422, 'Peserta belum lulus');
        $sertifikat = Sertifikat::firstOrCreate(['user_id' => $peserta->user_id, 'asesmen_id' => $peserta->asesmen_id], ['nomor_sertifikat' => 'SKW-'.str_pad((string) (Sertifikat::max('id') + 1), 4, '0', STR_PAD_LEFT), 'kompetensi_id' => $peserta->asesmen->kompetensi_id, 'level_id' => $peserta->asesmen->level_id, 'nilai_akhir' => $peserta->nilai, 'kategori_kompetensi' => $service->kategori((float) $peserta->nilai), 'tanggal_terbit' => now(), 'tanggal_expired' => now()->addYears(3), 'is_active' => true]);

        return response()->json($sertifikat->load('user', 'asesmen', 'kompetensi', 'level'));
    }

    public function download($id)
    {
        $sertifikat = Sertifikat::with('user', 'asesmen', 'kompetensi', 'level')->findOrFail($id);

        try {
            $baseUrl = \App\Models\Setting::where('key', 'cert_verify_url')->value('value');
        } catch (\Throwable $e) { $baseUrl = null; }
        $baseUrl = $baseUrl ?? url('/api/sertifikat/verify/'.$sertifikat->nomor_sertifikat);
        $verifyUrl = rtrim($baseUrl, '/').'/'.$sertifikat->nomor_sertifikat;

        $qrCode = QrCode::size(100)->generate($verifyUrl);

        $pdf = Pdf::loadView('sertifikat.pdf', ['sertifikat' => $sertifikat, 'qrCode' => $qrCode]);

        return $pdf->download($sertifikat->nomor_sertifikat.'.pdf');
    }

    public function verify($nomor)
    {
        return response()->json(Sertifikat::with('user', 'asesmen')->where('nomor_sertifikat', $nomor)->where('is_active', true)->firstOrFail());
    }
}
