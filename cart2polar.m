%% 用于将直角坐标转换为以区域中心为原点的极坐标系
%输入region，输出极坐标系半径和角度矩阵
function [radius, angle] = cart2polar(region_size)
radius = zeros(region_size(1), region_size(2));%极坐标半径
angle = zeros(region_size(1), region_size(2));%极坐标角度
center = [ceil(region_size(1)/2), ceil(region_size(2)/2)];
for row = 1:region_size(1)
    for col = 1:region_size(2)
        [theta,rho]=cart2pol(row-center(1),col-center(2));%直角坐标转极坐标
        radius(row,col) = log(rho);
        angle(row,col) = theta*180/pi + 180;
    end
end