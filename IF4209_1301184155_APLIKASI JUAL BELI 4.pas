Program AplikasiJualBeli4;
uses crt; 
    type 
        admin = record
            list_Adnama: array [1..2] of string;
            Adpass: string;
        end;

    type 
        lokasi = record
            LoPenjualan: string;
            rating: integer;
            jenis_barang: string;
            list_barang: array [1..10] of string;
            harga_barang: array [1..10]of longint;
        end;
    type tabel = array [1..50] of lokasi;
    type 
        user = record
            orang: string;
            alamat: string;
            pass: string;
            baranguser: string;
            jenis:string;
            harga: longint;
        end;
    type akunuser = array [1..30] of user;
    type temp = array [1..30] of integer;
var 
    pil,i,j,m: integer;
    adminn: Admin;
    tab: tabel;
    jumlahdata,jumlahakun,jumlahjual: longint;
    tabuser: akunuser;
    nama,pass: string;
    
procedure tampil(i:integer);
    begin
            writeln;
            writeln('indeks #',i);
            writeln('  Lokasi Jual Beli Barang Bekas             : ', tab[i].LoPenjualan);
            writeln('  Rating Lokasi Jual Beli (angka 1-5)       : ',tab[i].rating);
            writeln('  Jenis barang                              : ', tab[i].jenis_barang);
            writeln('  List Barang Jual Beli dan Harga Barang      : '); j:=1;
            while (tab[i].list_barang[j]<>'Selesai') do 
                begin 
                writeln(j,' : ',tab[i].list_barang[j],'  ',tab[i].harga_barang[j]);
                j:= j +1;
                end;
            writeln;
    end;


procedure cek(idx:integer; var valid : boolean);
    begin
        if tab[idx].LoPenjualan <> '' then
        begin
            valid:=true;
            writeln('data yang ini?');
            writeln;
                tampil(idx);
        end
        else 
            begin
            valid:=false;
            writeln('maaf data yang anda cari tidak ada :(');
            readln;
            end;
    end;
        
            
procedure insertdata (x: integer;stat: string);
    var
        pilihadmin:char;
    begin
        repeat
                clrscr;
                writeln('===================== Insert Data ========================');
                writeln;
                writeln;
                writeln('     Lokasi Jual Beli Barang Bekas         : '); readln(tab[x].LoPenjualan);
                writeln('     Rating Lokasi Jual Beli (angka 1-5)   : '); readln(tab[x].rating);
                writeln('     Jenis barang                          : '); readln(tab[x].jenis_barang);
                writeln('     List Barang Jual Beli dan Harga Barang: ');
                j:= 0;
                while (tab[x].list_barang[j]<>'Selesai') do 
                begin 
                j:= j +1 ;
                write(j,' : '); readln(tab[x].list_barang[j]); readln(tab[x].harga_barang[j]);
                end;
                if stat = 'ins'then
                    begin
                        write('Ingin nambah data lagi? [y/t] : '); readln(pilihadmin);
                        if pilihadmin = 'y' then
                            begin
                            inc(jumlahdata);
                            x:=jumlahdata;	
                            end;
                    end
                    else if stat = 'edit' then
                            begin
                                writeln('== Data Baru sudah tersimpan! ==');
                                readln;
                                pilihadmin:='t';
                            end;

        until (lowercase(pilihadmin)='t');
    end;

procedure editData();
        var
            idx,i: Integer;
            pilih:char;
            valid:boolean;
    begin
        clrscr;
        writeln;
        writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin >> Edit Data ===');
        writeln;
        for i:= 1 to jumlahdata do
            begin
                writeln(i,'. ',tab[i].LoPenjualan);
            end;
            write('masukkan nomor indeks yang ingin di edit : '); readln(idx);
        clrscr;
        cek(idx,valid);
        if valid then
            begin
                write('pilih [y/t] : '); readln(pilih);
                if lowercase(pilih) = 'y' then
                    begin
                        insertData(idx,'edit');
                    end;
            end;
    end;


procedure deleteData();
    var
        pilih: char;
        idx:byte;
        i:integer;
        valid:boolean;
    begin
        clrscr;
        writeln;
        writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin >> Delete Data ===');
        writeln; 
        for i:= 1 to jumlahdata do
            begin
                writeln(i,'. ',tab[i].LoPenjualan);
            end;
        write('masukkan nomor indeks tempat wisata : '); readln(idx);
        clrscr;
        cek(idx,valid);
        if valid then
            begin
                write('pilih : [y/t] : '); readln(pilih);
                if pilih = 'y'then
                begin
                    //hapus datanya
                    for i:= idx to jumlahdata do
                        begin
                            tab[i]:= tab[i+1]
                        end;
                    dec(jumlahdata);
                    writeln('== Data ke ',idx,' telah di hapus! ==')
                end;
            end;
    end;


procedure viewData();
    begin
    clrscr;
    i:= 1;
    while i<= jumlahdata do
    begin   
        tampil(i);
		inc(i);
    end; 
    write('press any key to continue.. '); readln;
    end;

procedure MenuAdmin;
    begin
        clrscr;
        writeln;
        writeln('  == Admin Menu ==');
        writeln('  1. Insert Data');
        writeln('  2. Edit barang');
        writeln('  3. Delete Data');
        writeln('  4. View Data');
        writeln('  5. Back');
        writeln;
        write('  ===> Pilih : '); readln(pil);
        if pil= 1 then 
        begin  
            insertdata(jumlahdata,'ins');
            clrscr;
            MenuAdmin
        end
        else if pil= 2 then
        begin
            editData();
            clrscr;
            MenuAdmin
        end
        else if pil= 3 then
        begin   
            deleteData();
            clrscr;
            MenuAdmin
        end
        else if pil= 4 then
        begin
            viewData();
            clrscr;
            MenuAdmin
        end;
    end;


procedure TambahanAdminn();
    var
        uname,pass: string;
    begin
        repeat
            clrscr;
            writeln;
            writeln(' === Main Menu >> Admin >> WelcomeAdmin >> LoginAdmin ===');
            writeln('hint : uname & pass = admin. kosongkan untuk kembali' );
            writeln('  == Login Admin ==');
            writeln;
            write  ('Admin yang ke:  '); readln(i);
            writeln;
            write  ('===> Username : '); readln(uname);
            write  ('===> Password  : '); readln(pass);
        until ((uname= adminn.list_Adnama[i] ) and (pass= adminn.Adpass)) or ((uname = '') or (pass = ''));
        if ((uname = adminn.list_Adnama[i]) and (pass = adminn.Adpass)) then
            MenuAdmin();
            
    end;


procedure TambahanAdmin();
    var
        pass: string;
    begin
        clrscr;
        writeln;
        writeln('==== Admin ====');
        i:=i+1;
        writeln;
        write  ('===> Username : '); readln(adminn.list_Adnama[i]);
        writeln;
        repeat
        write  ('===> Password : '); readln(pass);
        until (pass= adminn.Adpass);
        if (pass= adminn.Adpass) then 
            TambahanAdminn();
    end;


procedure loginAdmin();
    var
        uname,pass: string;
    begin
        repeat
        clrscr;
        writeln;
        writeln(' === Main Menu >> Admin >> WelcomeAdmin >> LoginAdmin ===');
        writeln('hint : uname & pass = admin. kosongkan untuk kembali' );
        writeln('  == Login Admin ==');
        writeln;
        write  ('===> Username  : '); readln(uname);
        write  ('===> Password  : '); readln(pass);
        until ((uname= adminn.list_Adnama[1] ) and (pass= adminn.Adpass)) or ((uname = '') or (pass = ''));
        if ((uname = adminn.list_Adnama[1] ) and (pass = adminn.Adpass)) then
            MenuAdmin();
            
    end;

procedure welcomeAdmin();
    begin
        repeat 
        clrscr;
        writeln;
        writeln('==== Main Menu >> Admin >> WelcomeAdmin ====');
        writeln('-----------------------------------------');
        writeln('-----------------------------------------');
        writeln('|      1.Admin                           '); 
        writeln('|      2.Tambahan Admin                  ');
        writeln('|      3.Kembali                         ');
        writeln('-----------------------------------------');
        writeln;
        write  ('   ===> Pilih : '); readln(pil);
        until (pil=3)or(pil=1)or(pil=2);
        case pil of
            1: begin loginAdmin(); end;
            2: begin TambahanAdmin(); end;
        end;
        
    end;

Procedure carlokasi( N: integer; var key: string);
    var
        valid: boolean;
        m: integer;
    begin
        m:= 1;
        valid:= false;
        while (valid= false) and (m <= jumlahdata) do
        begin
            if key = tab[m].LoPenjualan then
                valid:= true;
            i:= i+1;
        end;
        if (valid= true) then
        begin 
            tampil(m);
            writeln('data ketemu !');
        end
        else
            writeln('maaf data yang di cari tidak ada  :( ');
        write('press any key to continue.. '); readln;
    end;

procedure carJenis(N: integer; var key: string );
    var 
        tengah, atas, bawah: integer;
        ketemu: boolean;
    begin
        atas:= jumlahdata;
        bawah:= 1;
        ketemu:= False;
        while (ketemu= False) and (bawah <= atas) do
        begin 
            tengah:= (atas + bawah) div 2;
            if key = tab[tengah].jenis_barang then
                ketemu:= true
            else if key < tab[tengah].jenis_barang then
                atas:= tengah - 1
            else if key > tab[tengah].jenis_barang then
                bawah:= tengah + 1
        end;
        if key = tab[tengah].jenis_barang then
        begin 
            tampil(tengah);
            writeln('data ketemu !');
            write('press any key to continue.. '); 
            readln
        end
        else
        begin
            writeln('maaf data yang di cari tidak ada  :( ');
            write('press any key to continue.. '); readln;
        end;
    end;
                

procedure caridata();
    var 
        key: string;
        pilihan: integer;
    begin
        clrscr;
        writeln;
        writeln(' === Main Menu >> User >> Login >> Menu User >> Cari Data ===');
        writeln;
        writeln('  1. Cari Berdasarkan Lokasi Penjualan ');
        writeln('  2. Cari Berdasarkan Jenis Barang ');
        writeln('  3. Kembali ');
        writeln;
        write  ('===> Pilih : '); readln(pilihan);
        if pilihan= 1 then
        begin 
            clrscr;
            writeln;
            writeln('=========> Lokasi Ingin yang Anda Cari: ');readln(key);
            clrscr;
            carlokasi(jumlahdata,key)
        end
        else if pilihan= 2 then
        begin
            clrscr;
            writeln;
            writeln('=========> Jenis barang yang Ingin yang Anda Cari: ');readln(key);
            clrscr;
            carJenis(jumlahdata,key);
        end;
    end;



procedure cekUser(uname,pass: string; var valid: boolean);
    var
        cek: boolean;
    begin
	cek:= false;
	for i:=1 to jumlahakun do
		begin
		 	if (tabuser[i].orang = uname) and (tabuser[i].pass = pass) then
		 	begin
		 		cek:=true;
		 		nama:=tabuser[i].orang;
		 	end;
		 end; 
	valid := cek;
    end;


procedure jenis_barang(N: integer);
    var 
        pass,idx_min,m,pilihan,idx_max: integer;
        simpan: lokasi;
    begin
        repeat 
        clrscr;
        writeln;
        writeln('  urutkan dari : ');
        writeln('  1.Terkecil');
        writeln('  2.Terbesar');
        writeln;
        write('  Pilih : '); readln(pilihan);
        until (pilihan= 1) or (pilihan= 2);
        if pilihan= 1 then
        begin 
            clrscr;
             pass:= 1;
            while pass<= N- 1 do
            begin  
                idx_min:= pass;
                m:= pass + 1;
                while m <= N do
                begin 
                if tab[idx_min].jenis_barang > tab[m].jenis_barang then
                    idx_min:= m;
                m:= m + 1;
                end;
                simpan:= tab[idx_min];
                tab[idx_min]:= tab[pass];
                tab[pass]:= simpan;
                pass:= pass + 1;
            end;
        m:= 1;
        while m <= jumlahdata do
        begin 
            tampil(m);
            m:= m+ 1;
        end;
        readln;
        end
        else if pilihan= 2 then
        begin
            clrscr; 
            pass:= 1;
            while pass<= N- 1 do
            begin  
                idx_max:= pass;
                m:= idx_max + 1;
                while m <= N do
                begin 
                if tab[idx_max].jenis_barang < tab[m].jenis_barang then
                    idx_max:= m;
                m:= m + 1;
                end;
                simpan:= tab[idx_max];
                tab[idx_max]:= tab[pass];
                tab[pass]:= simpan;
                pass:= pass + 1;
            end;
        m:= 1;
        while m <= jumlahdata do
        begin 
            tampil(m);
            m:= m+ 1;
        end;
        readln;
        end;
    end;





procedure ratinglokasi(N: integer);
    var
        pass,idx_min,m,pilihan,idx_max: integer;
        simpan: lokasi;  
    begin
        repeat 
        clrscr;
        writeln;
        writeln('  urutkan dari : ');
        writeln('  1.Terkecil');
        writeln('  2.Terbesar');
        writeln;
        write('  Pilih : '); readln(pilihan);
        until (pilihan= 1) or (pilihan= 2);
        if pilihan= 1 then
        begin
            clrscr; 
            pass:= 1;
            while pass<= N- 1 do
            begin  
                idx_min:= pass;
                m:= pass + 1;
                while m <= N do
                begin 
                if tab[idx_min].rating > tab[m].rating then
                    idx_min:= m;
                m:= m + 1;
                end;
                simpan:= tab[idx_min];
                tab[idx_min]:= tab[pass];
                tab[pass]:= simpan;
                pass:= pass + 1;
            end;
        m:= 1;
        while m <= jumlahdata do
        begin 
            tampil(m);
            m:= m+ 1;
        end;
        readln;
        end
        else if pilihan= 2 then
        begin
            clrscr; 
            pass:= 1;
            while pass<= N- 1 do
            begin  
                idx_max:= pass;
                m:= idx_max + 1;
                while m <= N do
                begin 
                if tab[idx_max].rating < tab[m].rating then
                    idx_max:= m;
                m:= m + 1;
                end;
                simpan:= tab[idx_max];
                tab[idx_max]:= tab[pass];
                tab[pass]:= simpan;
                pass:= pass + 1;
            end;
        m:= 1;
        while m <= jumlahdata do
        begin 
            tampil(m);
            m:= m+ 1;
        end;
        readln;
        end;
    end;


procedure lokasibarang();
    begin
        clrscr;
        writeln;
        writeln('   Urutkan Berdasarkan :');
        writeln;
        writeln('   1.Rating Lokasi ');
		writeln('   2.Jenis Barang ');
        writeln('   3.Kembali ');
        writeln;
        write  ('  ===>Pilih : '); readln(pil);
        if pil= 1 then
        begin 
            ratinglokasi(jumlahdata);
            clrscr;
            lokasibarang();
        end
        else if pil= 2 then
        begin
            jenis_barang(jumlahdata);
            clrscr;
            lokasibarang();
        end;
    end;


procedure tampiluser(m: integer);
    begin
            writeln;
            writeln('indeks #',m);
            writeln('  Jenis Barang                              : ',tabuser[m].jenis);
            writeln('  Nama Barang                               : ',tabuser[m].baranguser);
            writeln('  Harga Barang                              : ', tabuser[m].harga);
            writeln;
    end; 

procedure viewUser();
    begin
    clrscr;
    m:= 1;  
    while m <= jumlahjual do
    begin 
        tampiluser(m);
		inc(m);
        readln;
    end; 
    write('press any key to continue.. '); readln;
    end;


procedure UserJual(y: integer; stat: string);
    var
        pilihanuser: char;
    begin
        repeat
            clrscr;
            writeln('============================================');
            writeln;
            write('=======> Nama User : ',nama);
            writeln;
            write('=======> Nama Barang  : '); readln(tabuser[y].baranguser);
            write('=======> Jenis Barang : '); readln(tabuser[y].jenis);
            write('=======> Harga Barang : '); readln(tabuser[y].harga);
            writeln;
            writeln;
            if stat = 'ins'then
                        begin
                            write('Ingin nambah data lagi? [y/t] : '); readln(pilihanuser);
                            if pilihanuser = 'y' then
                                begin
                                inc(jumlahjual);
                                y:=jumlahjual;	
                                end;
                        end;
        until (lowercase(pilihanuser)='t');
    end;


procedure menuUser();
    begin
        clrscr;
        writeln;
        writeln(' === Main Menu >> User >> Login >> Menu User ===');
        writeln;
        writeln('     Selamat Datang, ',nama);
        writeln;
        writeln('  1. Barang yang Ingin Dijual ');
        writeln('  2. Lihat Data Barang yang Ingin Dijual ');
        writeln('  3. Lihat Semua Lokasi Penjualan Barang Bekas ');
        writeln('  4. Cari Penjualan Barang Bekas ');
        writeln('  5. Kembali ');
        writeln;
        write  ('===> Pilih : '); readln(pil);
        if pil= 1 then
            begin
            userjual(jumlahjual,'ins');   
            clrscr;
            menuUser()
            end
        else if pil= 2 then
            begin
            viewUser();
            clrscr;
            menuUser();
            end
        else if pil= 3 then
            begin
            lokasibarang();
            clrscr;
            menuUser;
            end
        else if pil= 4 then
            begin
            caridata();
            clrscr;
            menuUser;
            end;
    end;

procedure Registrasi(); 
    begin
        clrscr;
        inc(jumlahakun);
        writeln;
        writeln('============ Registrasi =============');
        writeln;
        write('=====> Nama     : '); readln(tabuser[jumlahakun].orang);
        write('=====> Passwword: '); readln(tabuser[jumlahakun].pass);
        write('=====> alamat   : '); readln(tabuser[jumlahakun].alamat);
        writeln;
        writeln;
        writeln('Registrasi Selesai, Data tersimpan.');
        writeln;
        write('press anykey to continue.. '); readln;
    end;


procedure loginUser();
    var
        uname, pass: string;
        valid: boolean;
    begin
        clrscr;
        writeln(' === Main Menu >> User >> Login ===');
        writeln;
        writeln('   ==Login==    ');    
        write  ('===> Username : '); readln(uname);
        write  ('===> Password : '); readln(pass);
        cekUser(uname,pass,valid);
        if valid then
            menuUser()
        else
        begin
            writeln;
            writeln('!!!! username atau password yang anda masukkan salah !!!!');
            write('press any key to continue..'); readln;
        end;
	end;


procedure WelcomeUser();
    begin
        repeat
        clrscr;
        writeln;
        writeln(' === Main Menu >> User ===');
        writeln;
        writeln('     1. Login ');
        writeln('     2. Registrasi ');
        writeln('     3. Kembali ');
        writeln;
        write  ('===> Pilih : ');readln(pil);
        until (pil=3)or(pil=1)or(pil=2);
            case pil of
                1: begin loginUser(); end;
                2: begin registrasi(); end;
            end;
    end;

procedure mainmenu();
    begin
        repeat 
        clrscr;
        writeln('--------------------------------------------------');
        writeln('===========       Selamat Datang        ==========');
        writeln('============== Aplikasi Jual Beli 4 ==============');
        writeln('--------------------------------------------------');
        writeln('-------------------------------------------------- ');
        writeln('|     Main Menu                                  | ');
        writeln('|     1.Admin                                    | ');
        writeln('|     2.User                                     | ');
        writeln('|     3.Log Out                                  | ');
        writeln('--------------------------------------------------');
        writeln;
        write  ('   ===> Pilih : '); 
        readln(pil);
        until (pil=3)or(pil=1)or(pil=2);
        if pil= 1 then
        begin
            clrscr;
            welcomeAdmin();
            clrscr;
            mainmenu();
        end
        else if pil= 2 then
        begin
            clrscr;
            WelcomeUser();
            clrscr;
            mainmenu();
        end;
    end;
     
begin
    i:= 1;
    jumlahdata:= 1;
    jumlahjual:= 1;
    adminn.list_Adnama[1]:= 'rezi';
    adminn.Adpass:= 'rezi';
    mainmenu();
end.