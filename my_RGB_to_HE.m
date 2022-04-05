clc;clear;
% 对课本《数字图像处理学》"直方图均衡化"一节知识点的复现
PATH='resourse/woman.tiff';
I = imread(PATH);
I_mixed = [I(:,:,1);I(:,:,2);I(:,:,3)];
%Statistics:
x = double(unique(I_mixed));
y = zeros(size(x));
[r,col] = size(I_mixed);
for i = 1:r
    for k = 1:col
        for j = I_mixed(i,k)
            y(x==j) = y(x==j) + 1;%统计灰度值的像素个数
        end
    end
end
stat = [x,y];%统计结果，stat(1)与stat(2)分别代表图像的每种灰度值和与之对应的像素个数
n = r*col;%总像素个数
%以下代码复用某些变量以图简洁
[r,~] = size(stat);
z = zeros(size(x));
for i = 1:r
    y(i) = stat(i,2)/n;%计算每种灰度值出现的频率
    for j = 1:i
        z(i) = z(i)+y(j);%计算累积概率
    end
end
%p_stat在stat基础上增加第三列：灰度级对应出现的频率；第四列：累积概率
p_stat = [stat,y,z];
%直方图均衡：
[r,~] = size(p_stat);
for i = 1:r
     y(i) = round(p_stat(i,4)*max(x));%映射；四舍五入取整
end
p_stat = [p_stat,y];
[row,col,dep] = size(I);
for d = 1:dep
    for r = 1:row
        for c = 1:col
            for base = I(r,c,d)
                %在p_stat第一列找与I灰度值相同的对应值
                [a,~] = find(p_stat(:,1)==base);
                I(r,c,d) = p_stat(a,5);%修改原先图像
            end
        end
    end
end
%打印
subplot(1,2,1);imshow(I,[]);title('HE');
subplot(1,2,2);histogram(I);title('Histogram');