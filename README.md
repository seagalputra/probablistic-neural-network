# probablistic-neural-network

Introduce by Donald F. Specht in the early 1990s. PNN is a feed forward Neural Network. PNN consist of 4 layer architectures, that is input layer, pattern layer, summation layer, and output layer.

# How to use

Melakukan proses training terhadap Data Train :

1. Buka file malin.m menggunakan MATLAB
2. Import file Data Train menggunakan format .csv atau .xlsx
3. Jalankan file malin.m
4. Ubah nilai variable s untuk nilai sigma apabila dibutuhkan (default nilai sigma : 1)
5. Akan dioutputkan hasil dari Data Train pada command window MATLAB

Melakukan proses testing terhadap Data Test :

1. Buka file malin_testing.m menggunakan MATLAB
2. Import file Data Train dan Data Test menggunakan format .csv atau .xlsx
3. Jalankan file malin_testing.m
4. Ubah nilai variable s untuk nilai sigma apabila dibutuhkan (default nilai sigma : 1)
5. Hasil proses klasifikasi akan dioutputkan pada file prediksi.txt

# Known Bugs

* Program error apabila nilai variable s terlalu besar nilainya (contohnya : 100)