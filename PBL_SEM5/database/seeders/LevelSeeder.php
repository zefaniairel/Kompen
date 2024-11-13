<?php
namespace Database\Seeders;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class LevelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            ['level_id' => 1, 'level_kode' => 'ADM', 'nama' => 'Admini'],
            ['level_id' => 2, 'level_kode' => 'DSN', 'nama' => 'Dosen'],
            ['level_id' => 3, 'level_kode' => 'TDK', 'nama' => 'Tendik'],
            ['level_id' => 4, 'level_kode' => 'KPRD', 'nama' => 'Kaprodi'],
        ];
        DB::table('m_level')->insert($data);
    }
}