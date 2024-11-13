<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProdiModel extends Model
{
    protected $table = 'm_prodi';
    protected $primaryKey = 'prodi_id';
    protected $guarded = [];

    public function mahasiswas()
    {
        return $this->hasMany(MahasiswaModel::class, 'prodi_id');
    }

    public function admins()
    {
        return $this->hasMany(AdminModel::class, 'prodi_id');
    }
}