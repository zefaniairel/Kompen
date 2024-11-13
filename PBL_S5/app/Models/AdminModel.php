<?php

// app/Models/Admin.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminModel extends Model
{
    protected $table = 'm_admin';
    protected $primaryKey = 'admin_id';
    protected $guarded = [];

    public function prodi()
    {
        return $this->belongsTo(ProdiModel::class, 'prodi_id');
    }
}