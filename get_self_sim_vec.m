%% 用于将相似性转换为自相似性描述子
%输入patch和region的相似性矩阵，输出极坐标转换及取bin操作后的自相似性描述子向量
function self_similarities_vec = get_self_sim_vec(ssd_region, bin, vec_size)

self_similarities_vec = zeros(1, vec_size);%初始化像素点处的描述子
num = 0;
for m = 0:14
    for n = 0:2
        temp = bin{m+1, n+1};
        max_value = 0;
        %找到属于同一个bin中的最大值
        temp_size = size(temp);
        for loc = 1:temp_size(2)
            row = temp(1, loc);
            col = temp(2, loc);
            max_value = max(max_value, ssd_region(row, col));
        end
        num = num + 1;
        self_similarities_vec(num)=max_value;
    end
end
