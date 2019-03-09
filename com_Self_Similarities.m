%% 用于计算图片的自相似性描述子
function self_similarities = com_Self_Similarities(src_image,region_size,patch_size, bin)
t1=clock;%计时

%%
%读取图像并转换到lab空间
figure;imshow(src_image);
cform = makecform('srgb2lab'); % rgb转换lab
lab_image = applycform(src_image,cform);
% figure;imshow(lab_image);

%%
%计算每个像素点的自相似性描述子
lab_size = size(lab_image);
vec_size = 45;%45个bin
alpha = 1/(85^2);%计算相似性用的参数alpha
self_similarities = zeros(lab_size(1), lab_size(2), vec_size);
center_region = [floor(region_size(1)/2), floor(region_size(2)/2)];
center_patch = [floor(patch_size(1)/2), floor(patch_size(2)/2)];
for row=center_region(1)+1:1:lab_size(1)-center_region(1)
    for col=center_region(2)+1:1:lab_size(2)-center_region(2)
        patch = lab_image(row-center_patch(1):row + center_patch(1), col-center_patch(1):col + center_patch(1), :);%取patch
        region = lab_image(row-center_region(1):row + center_region(1), col-center_region(2):col + center_region(2), :);%取region
        SSD_region = cal_ssd(patch, region, alpha, center_patch);%计算相似性
        vec = get_self_sim_vec(SSD_region, bin, vec_size);%相似性转换为自相似性描述子
        [LSSD,ps]=mapminmax(vec' ,0,1);%对描述子归一化
        self_similarities(row, col, :) = LSSD';
    end
end
t2=clock;
etime(t2,t1);