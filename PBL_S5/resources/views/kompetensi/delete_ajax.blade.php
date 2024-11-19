@empty($kompetensi)
   <div id="modal-master" class="modal-dialog modal-lg" role="document">
       <div class="modal-content">
           <div class="modal-header">
               <h5 class="modal-title">Kesalahan</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           </div>
           <div class="modal-body">
               <div class="alert alert-danger">
                   <h5><i class="icon fas fa-ban"></i> Kesalahan!!!</h5>
                   Data yang anda cari tidak ditemukan
               </div>
               <a href="{{ url('/kompetensi') }}" class="btn btn-warning">Kembali</a>
           </div>
       </div>
   </div>
@else
   <form action="{{ url('/kompetensi/' . $kompetensi->kompetensi_id . '/delete_ajax') }}" method="POST" id="form-delete">
       @csrf
       @method('DELETE')
       <div id="modal-master" class="modal-dialog modal-lg" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title">Hapus Data Kompetensi</h5>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
               </div>
               <div class="modal-body">
                   <div class="alert alert-warning">
                       <h5><i class="icon fas fa-ban"></i> Konfirmasi !!!</h5>
                       Apakah Anda ingin menghapus data seperti di bawah ini?
                   </div>
                   <table class="table table-sm table-bordered table-striped">
                       <tr>
                           <th class="text-right col-3">Deskripsi:</th>
                           <td class="col-9">{{ $kompetensi->deskripsi }}</td>
                       </tr>
                       <tr>
                           <th class="text-right col-3">Mahasiswa:</th>
                           <td class="col-9">{{ $kompetensi->mahasiswa->nama ?? '-' }}</td>
                       </tr>
                   </table>
               </div>
               <div class="modal-footer">
                   <button type="button" data-dismiss="modal" class="btn btn-warning">Batal</button>
                   <button type="submit" class="btn btn-primary">Ya, Hapus</button>
               </div>
           </div>
       </div>
   </form>
   <script>
       $(document).ready(function() {
           $("#form-delete").validate({
               rules: {},
               submitHandler: function(form) {
                   $.ajax({
                       url: form.action,
                       type: form.method,
                       data: $(form).serialize(),
                       success: function(response) {
                           if (response.status) {
                               $('#myModal').modal('hide');
                               Swal.fire({
                                   icon: 'success',
                                   title: 'Berhasil',
                                   text: response.message
                               });
                               tableKompetensi.ajax.reload();
                           } else {
                               $('.error-text').text('');
                               $.each(response.msgField, function(prefix, val) {
                                   $('#error-' + prefix).text(val[0]);
                               });
                               Swal.fire({
                                   icon: 'error',
                                   title: 'Terjadi Kesalahan',
                                   text: response.message
                               });
                           }
                       }
                   });
                   return false;
               }
           });
       });
   </script>
@endempty