<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Schema;

class SettingController extends Controller
{
    public function index()
    {
        if (!Schema::hasTable('settings')) {
            return response()->json(['cert_verify_url' => url('/api/sertifikat/verify')]);
        }
        $settings = Setting::pluck('value', 'key');
        if (!$settings->has('cert_verify_url')) {
            $settings['cert_verify_url'] = url('/api/sertifikat/verify');
        }
        return response()->json($settings);
    }

    public function update(Request $request)
    {
        $data = $request->validate([
            'cert_verify_url' => ['required', 'url'],
        ]);
        Setting::updateOrCreate(['key' => 'cert_verify_url'], ['value' => $data['cert_verify_url']]);
        return response()->json(['message' => 'Pengaturan berhasil disimpan']);
    }
}
