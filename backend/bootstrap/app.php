<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->statefulApi();

        $middleware->validateCsrfTokens(except: [
            'api/*',
        ]);

        // === AWAL BLOK KODE YANG DIEDIT (CUSTOM CORS GLOBAL MIDDLEWARE) ===
        $middleware->append(function (Request $request, \Closure $next) {
            // 1. Tangani Preflight Request (OPTIONS) yang dikirim browser sebelum POST
            if ($request->isMethod('OPTIONS')) {
                return response('', 200)
                    ->header('Access-Control-Allow-Origin', 'https://sikawan.up.railway.app')
                    ->header('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, PUT, DELETE')
                    ->header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept')
                    ->header('Access-Control-Allow-Credentials', 'true');
            }

            // 2. Lanjutkan request biasa (POST/GET) ke controller
            $response = $next($request);

            // 3. Suntikkan header CORS ke response sebelum dikirim balik ke frontend
            if (method_exists($response, 'header')) {
                $response->header('Access-Control-Allow-Origin', 'https://sikawan.up.railway.app')
                         ->header('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, PUT, DELETE')
                         ->header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With, Accept')
                         ->header('Access-Control-Allow-Credentials', 'true');
            }

            return $response;
        });
        // === AKHIR BLOK KODE YANG DIEDIT ===
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->is('api/*'),
        );
    })->create();
