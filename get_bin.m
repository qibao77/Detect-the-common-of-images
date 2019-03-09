%% 用于将极坐标系划分为15*3=45个bin（论文中采用80bin，但是处理太慢，这里把图像进行了缩放，因此相应减少了bin的划分）
%输入极坐标表示的半径和角度矩阵，输出划分好的bin
function bin = get_bin(radius, angle, region_size)
max_radius = max(max(radius));%最大半径
bin = cell(15, 3)
for m = 0:14
    theta_low = m*24;theta_up = (m+1)*24;
    for n = 0:2
        rho_low = max_radius*n/3;rho_up = max_radius*(n+1)/3;
        %循环整个region，找到属于同一个bin的图像位置，保存到cell中
        temp = [];num = 0;
        for row = 1:region_size(1)
            for col = 1:region_size(2)
                if (radius(row, col)>=rho_low) & (radius(row, col)<=rho_up) & (angle(row, col)>=theta_low) & (angle(row, col)<=theta_up)
                    num = num + 1;
                    temp(1,num) = row;temp(2,num) = col;
                end
            end
        end
        bin{m+1, n+1}=temp;
    end
end