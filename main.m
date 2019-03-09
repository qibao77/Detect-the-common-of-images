%% 计算每张图片的自相似性描述子表示

n_img=5;% 测试图片数量
n_test = 2;
region_size = [45, 37];
patch_size = [5, 5];
[radius, angle] = cart2polar(region_size);%用于将直角坐标转换为以区域中心为原点的极坐标系
bin = get_bin(radius, angle, region_size);%用于将极坐标系划分为80个bin

for m=1:n_img
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    imgRgb = imresize(src_img,1/3);
    self_similarities = com_Self_Similarities(imgRgb,region_size,patch_size, bin);
    savePath = sprintf('self_similarities0%d.mat', m);
    save(savePath,'self_similarities');  % 保存每副图像的自相似性描述子mat
end

%%
%计算显著性得分
width = 1;height = 1;%设置子图像大小为100*100
center_sub = [floor(width/2), floor(height/2)];
p = 1;%距离度量采用2范数
self_similarities=cell(1,n_img);
for m = 1:n_img
    Path = sprintf('self_similarities0%d.mat', m);
    temp = load(Path);%载入图像的自相似性描述子
    self_similarities1 = temp.self_similarities;
    img_size1 = size(self_similarities1);
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    imgRgb = imresize(src_img,1/3);
    sig_score_img = zeros(img_size1(1),img_size1(2));
    for row1 = center_sub(1)+1:img_size1(1)-center_sub(1)-1
        for col1 = center_sub(2)+1:img_size1(2)-center_sub(2)-1                 
            sub1 = self_similarities1(row1-center_sub(1):row1+center_sub(1),col1-center_sub(2):col1+center_sub(2),:);%第一幅图像的子图像
            max_match = zeros(1, n_img-1);%记录与其他各个图像的块的最大匹配得分
            num_img=1;
            match_score = cell(n_img);%记录与其他各个图像的块的匹配得分
            %计算与其他图像的相似性
            for n = 1:n_img               
                if n~=m
                    Path = sprintf('self_similarities0%d.mat', n);
                    temp = load(Path);
                    self_similarities2 = temp.self_similarities;                   
                    temp1 = repmat(sub1,[size(self_similarities2,1),size(self_similarities2,2)]);
                    temp2 =-1.*(sum((self_similarities2 - temp1).^2,3));
                    max_match(1,num_img) = max(max(temp2));%记录与每副图像的最大匹配得分
                    match_score{num_img} = reshape(temp2,[],1);           
                    num_img=num_img+1;
                end
            end
            %计算显著性得分
            temp3 = [match_score{1};match_score{2};match_score{3};match_score{4};match_score{5}];
            avgMatch = mean(temp3);%该像素点处的矩形框在其它所有图像中的平均匹配得分
            stdMatch = std(temp3);%匹配得分标准差
            sig_score_img(row1,col1) = sum((max_match(:)-avgMatch(:))./stdMatch(:));
        end
    end

    savePath = sprintf('sig_img11%d.mat', m);
	save(savePath,'sig_score_img');  % 保存每副图像显著性得分mat
	
	Path = sprintf('sig_img11%d.mat', m);
    temp = load(Path);
    sig_score_img = temp.sig_score_img;
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    draw_result(src_img, sig_score_img./4, [45, 37],3);%框出每幅图片检测到的共同目标
     
end