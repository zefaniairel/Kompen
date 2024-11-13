<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MahasiswaModel extends Model
{
    protected $table = 'm_mahasiswa';
    protected $primaryKey = 'mahasiswa_id';
    protected $guarded = [];

    public function prodi()
    {
        return $this->belongsTo(ProdiModel::class, 'prodi_id');
    }

    public function kompetensis()
    {
        return $this->hasMany(KompetensiModel::class, 'mahasiswa_id');
    }
}