select *
from airplane_price_dataset apd 
order by tahun_produksi desc 

alter table airplane_price_dataset 
rename column "Üretim Yılı" to Tahun_Produksi

alter table airplane_price_dataset 
rename column "Motor Sayısı" to Nomor_Mesin

alter table airplane_price_dataset 
rename column "Motor Türü" to Jenis_Mesin

alter table airplane_price_dataset 
rename column "Kapasite" to Kapasitas_Model

alter table airplane_price_dataset 
rename column "Menzil (km)" to Jangkauan_KM

alter table airplane_price_dataset 
rename column "Yakıt Tüketimi (L/saat)" to "Konsumsi_Bahan_Bakar_(L/jam)"

alter table airplane_price_dataset 
rename column "Saatlik Bakım Maliyeti ($)" to "Biaya_Perawatan_Per_Jam_($)"

alter table airplane_price_dataset 
rename column "Yaş" to Usia_Model

alter table airplane_price_dataset 
rename column "Satış Bölgesi" to Area_Penjualan

alter table airplane_price_dataset 
rename column "Fiyat ($)" to "Harga_($)"

---cek duplicate



select *,
ROW_NUMBER()OVER(
partition by "Model",tahun_produksi,nomor_mesin,jenis_mesin,area_penjualan,"Biaya_Perawatan_Per_Jam_($)","Konsumsi_Bahan_Bakar_(L/jam)") as row_num
from airplane_price_dataset apd ;



with duplicate_cte as 
(
select *,
ROW_NUMBER()OVER(
partition by "Model",tahun_produksi,nomor_mesin,jenis_mesin,area_penjualan,"Biaya_Perawatan_Per_Jam_($)",
"Konsumsi_Bahan_Bakar_(L/jam)") as row_num
from airplane_price_dataset apd
)
select *
from duplicate_cte
where row_num > 1;


