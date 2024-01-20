<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gategore extends Model
{
    use HasFactory;

    protected $table = 'gategore';
    protected $fillable = ['title', 'descrition'];
}