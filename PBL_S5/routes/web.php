<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\KompetensiController;
use App\Http\Controllers\LevelController;
use App\Http\Controllers\WelcomeController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/', [WelcomeController::class,'index']);         // menampilkan halaman awal level

Route::group(['prefix' => 'level'], function () {
    Route::get('/level', [LevelController::class, 'index']);          // menampilkan halaman awal level
    Route::post('/level/list', [LevelController::class, 'list']);      // menampilkan data level dalam bentuk json untuk datatables
    Route::get('/level/create', [LevelController::class, 'create']);   // menampilkan halaman form tambah level
    Route::post('/level', [LevelController::class, 'store']);         // menyimpan data level baru
    Route::get('/level/{id}', [LevelController::class, 'show']);       // menampilkan detail level
    Route::get('/level/{id}/edit', [LevelController::class, 'edit']);  // menampilkan halaman form edit level
    Route::put('/level/{id}', [LevelController::class, 'update']);     // menyimpan perubahan data level
    Route::delete('/level/{id}', [LevelController::class, 'destroy']); // menghapus data level
}); 

Route::prefix('admin')->group(function () {
    Route::get('/', [AdminController::class, 'index'])->name('admin.index');
    Route::post('/list', [AdminController::class, 'list'])->name('admin.list');
    Route::get('/create', [AdminController::class, 'create'])->name('admin.create');
    Route::post('/', [AdminController::class, 'store'])->name('admin.store');
    Route::post('/store-ajax', [AdminController::class, 'store_ajax'])->name('admin.store_ajax');
    Route::get('/{id}', [AdminController::class, 'show'])->name('admin.show');
    Route::get('/{id}/edit', [AdminController::class, 'edit'])->name('admin.edit');
    Route::put('/{id}', [AdminController::class, 'update'])->name('admin.update');
    Route::put('/{id}/update-ajax', [AdminController::class, 'update_ajax'])->name('admin.update_ajax');
    Route::delete('/{id}', [AdminController::class, 'destroy'])->name('admin.destroy');
    Route::get('/{id}/confirm', [AdminController::class, 'confirm_ajax'])->name('admin.confirm');
});

Route::prefix('kompetensi')->group(function () {
    Route::get('/', [KompetensiController::class, 'index'])->name('kompetensi.index');
    Route::post('/kompetensi/list', [KompetensiController::class, 'list'])->name('kompetensi.list');
    Route::get('/create', [KompetensiController::class, 'create'])->name('kompetensi.create');
    Route::post('/', [KompetensiController::class, 'store'])->name('kompetensi.store');
    Route::get('/{kompetensi}', [KompetensiController::class, 'show'])->name('kompetensi.show');
    Route::get('/{kompetensi}/edit', [KompetensiController::class, 'edit'])->name('kompetensi.edit');
    Route::put('/{kompetensi}', [KompetensiController::class, 'update'])->name('kompetensi.update');
    Route::delete('/{kompetensi}', [KompetensiController::class, 'destroy'])->name('kompetensi.destroy');
    Route::get('/{kompetensi}/confirm', [KompetensiController::class, 'confirm_ajax'])->name('kompetensi.confirm');
});