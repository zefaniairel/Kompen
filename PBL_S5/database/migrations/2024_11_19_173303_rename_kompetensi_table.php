<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::rename('kompetensi', 'm_kompetensi');
    }

    public function down()
    {
        Schema::rename('m_kompetensi', 'kompetensi');
    }
};