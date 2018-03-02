%% Melakukan testing menggunakan model probabilistik

clear;
clc;
close all;

% Membaca data Train dan data Test
dataTrain = csvread('data_train_PNN.csv');
dataTest = csvread('data_test_PNN.csv');
train = dataTrain(1:150,:);
valid = dataTest(1:30,:);
train_sort = sortrows(train, 4);

% Memisahkan data train sesuai dengan kelasnya
jumlahAtribut = size(train,2)-1;
data_kelas = train(:,jumlahAtribut+1);
data_train = train(:,1:jumlahAtribut);
data_train0 = data_train(find(data_kelas==0),:);
data_train1 = data_train(find(data_kelas==1),:);
data_train2 = data_train(find(data_kelas==2),:);

% Smoothing parameter
s = 1;

% hitung g(x) dengan memisahkan setiap data train per kelasnya
for i = 1:size(valid)
    % Perhitungan f(x) pada kelas 0
    for j = 1:size(data_train0)
        kelas0(i,1) = exp(-(((valid(i,1)-data_train0(j,1))^2 + (valid(i,2)-data_train0(j,2))^2 + (valid(i,3)-data_train0(j,3))^2) / 2*s^2));
        f(i,1) = sum(kelas0(i,1))/size(data_train0,1);
    end
    
    % Perhitungan f(x) pada kelas 1
    for l = 1:size(data_train1)
        kelas1(i,1) = exp(-(((valid(i,1)-data_train1(l,1))^2 + (valid(i,2)-data_train1(l,2))^2 + (valid(i,3)-data_train1(l,3))^2) / 2*s^2));
        f(i,2) = sum(kelas1(i,1))/size(data_train1,1);
    end
    
    % Perhitungan f(x) pada kelas 2
    for n = 1:size(data_train2)
        kelas2(i,1) = exp(-(((valid(i,1)-data_train2(n,1))^2 + (valid(i,2)-data_train2(n,2))^2 + (valid(i,3)-data_train2(n,3))^2) / 2*s^2));
        f(i,3) = sum(kelas2(i,1))/size(data_train2,1);
    end

    % Mencari nilai maksimum pada setiap baris matrix f(x)
    for k = 1:size(f)
        max_f(k,1) = max(f(k,1:3));
        if (find(max_f(k,1) == f(k,1:3)) == 1)
            klasifikasi(k,1) = 0;
        elseif (find(max_f(k,1) == f(k,1:3)) == 2)
            klasifikasi(k,1) = 1;
        elseif (find(max_f(k,1) == f(k,1:3)) == 3)
            klasifikasi(k,1) = 2;
        end
    end
end

% Menggabungkan data test dengan kelasifikasi kelasnya
valid(:,4) = klasifikasi(:,1);

% Menulis data pada text file
fileID = fopen('hasil_testing.txt','w');
fprintf(fileID, '%6s %6s %6s %1s\r\n','atr1','atr2','atr3','y');
fprintf(fileID, '%6.9f %6.9f %6.9f %1i\r\n',valid);

% Menampilkan data test ke grafik
dataTest_sort = sortrows(valid,4);
class0_test = dataTest_sort(1:16,1:3);
class1_test = dataTest_sort(17:23,1:3);
class2_test = dataTest_sort(24:30,1:3);

plot3(class0_test(:,1),class0_test(:,2),class0_test(:,3),'ro');
hold on;
plot3(class1_test(:,1),class1_test(:,2),class1_test(:,3),'bo');
hold on;
plot3(class2_test(:,1),class2_test(:,2),class2_test(:,3),'go');
hold on;