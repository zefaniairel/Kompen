<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KompetensiModel extends Model
{
    protected $table = 'm_kompetensi';
    protected $primaryKey = 'kompetensi_id';
    protected $guarded = [];

    public function mahasiswa()
    {
        return $this->belongsTo(MahasiswaModel::class, 'mahasiswa_id');
    }
}