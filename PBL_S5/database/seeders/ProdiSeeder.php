<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProdiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'prodi_id' => 1,
                'prodi_kode' => 'TI',
                'nama' => 'Teknik Informatika',
            ],
            [
                'prodi_id' => 2,
                'prodi_kode' => 'SIB',
                'nama' => 'Sistem Informasi Bisnis',
            ],
            [
                'prodi_id' => 3,
                'prodi_kode' => 'PPLS',
                'nama' => 'Pengembangan Piranti Lunak Situs'
            ],
        ];

        DB::table('m_prodi')->insert($data); // Sesuaikan nama tabel dengan tabel di database Anda
    }
}