<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB; // Import DB

class MahasiswaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'mahasiswa_id' => 1,
                'nama' => 'John Doe',
                'nim' => '12345',
                'username' => 'johndoe',
                'kompetensi' => 'Web Development',
                'semester' => 1,
                'password' => Hash::make('12345'),
                'foto' => 'default.jpg',
                'prodi_id' => 1,
                'kompetensi_id' => 1,
                'level_id' => 2,
            ],
        ];

        DB::table('m_mahasiswa')->insert($data);
    }
}