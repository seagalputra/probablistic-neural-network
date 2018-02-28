%% Memplot data menggunakan grafik

clear;
clc;
close all;

% Load data dan membedakan data berdasarkan kelasnya
dataTrain = csvread('data_train_PNN.csv');
dataTrain_sort = sortrows(dataTrain,4);
class0 = dataTrain_sort(1:46,:);
class1 = dataTrain_sort(47:94,:);
class2 = dataTrain_sort(95:150,:);

% Memplot grafik berdasarkan kelasnya
plot3(class0(:,1),class0(:,2),class0(:,3),'ro');
hold on;
plot3(class1(:,1),class1(:,2),class1(:,3),'bo');
hold on;
plot3(class2(:,1),class2(:,2),class2(:,3),'go');

%% Membangun fungsi utama probabilistik

% Menggunakan data Train
train = dataTrain(1:100,:);
valid = dataTrain(101:150,:);
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

% hitung g(x)
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
    
    % Memindahkan kelas pada data validasi ke matrix f(x)
    f(i,4) = valid(i,4);
    
    % Mencari nilai maksimum pada setiap baris matrix f(x)
%     for k = 1:size(f)
%         max_f(k,1) = max(f(k,1:3));
%         if (find(max_f(k,1) == f(k,1:3)) == f(k,1))
%             klasifikasi(k,1) = 0;
%         elseif(find(max_f(k,1) == f(k,1:3)) == f(k,2))
%             klasifikasi(k,1) = 1;
%         elseif(find(max_f(k,1) == f(k,1:3)) == f(k,3))
%             klasifikasi(k,1) = 2;
%         end
%     end
end