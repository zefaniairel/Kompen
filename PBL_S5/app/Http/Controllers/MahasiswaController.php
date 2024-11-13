<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use App\Models\MahasiswaModel;
use App\Models\Prodi;
use App\Models\ProdiModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class MahasiswaController extends Controller
{
    public function index()
    {
        $mahasiswas = MahasiswaModel::with('prodi')->paginate(10);
        return view('mahasiswa.index', compact('mahasiswas'));
    }

    public function create()
    {
        $prodis = ProdiModel::all();
        return view('mahasiswa.create', compact('prodis'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama' => 'required',
            'nim' => 'required|unique:m_mahasiswa',
            'username' => 'required|unique:m_mahasiswa',
            'password' => 'required|min:6',
            'prodi_id' => 'required|exists:m_prodi,prodi_id',
        ]);

        $data = $request->all();
        $data['password'] = Hash::make($request->password);
        
        if ($request->hasFile('foto')) {
            $file = $request->file('foto');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->storeAs('public/mahasiswa', $filename);
            $data['foto'] = $filename;
        }

        MahasiswaModel::create($data);
        return redirect()->route('mahasiswa.index')->with('success', 'Mahasiswa created successfully');
    }

    public function edit(MahasiswaModel $mahasiswa)
    {
        $prodis = ProdiModel::all();
        return view('mahasiswa.edit', compact('mahasiswa', 'prodis'));
    }

    public function update(Request $request, MahasiswaModel $mahasiswa)
    {
        $request->validate([
            'nama' => 'required',
            'nim' => 'required|unique:m_mahasiswa,nim,' . $mahasiswa->mahasiswa_id . ',mahasiswa_id',
            'username' => 'required|unique:m_mahasiswa,username,' . $mahasiswa->mahasiswa_id . ',mahasiswa_id',
            'prodi_id' => 'required|exists:m_prodi,prodi_id',
        ]);

        $data = $request->all();
        
        if ($request->has('password')) {
            $data['password'] = Hash::make($request->password);
        } else {
            unset($data['password']);
        }

        if ($request->hasFile('foto')) {
            $file = $request->file('foto');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->storeAs('public/mahasiswa', $filename);
            $data['foto'] = $filename;
        }

        $mahasiswa->update($data);
        return redirect()->route('mahasiswa.index')->with('success', 'Mahasiswa updated successfully');
    }

    public function destroy(MahasiswaModel $mahasiswa)
    {
        $mahasiswa->delete();
        return redirect()->route('mahasiswa.index')->with('success', 'Mahasiswa deleted successfully');
    }
}