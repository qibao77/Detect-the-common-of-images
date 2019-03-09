%% º∆À„patch”ÎregionµƒSSD
function SSD_region = cal_ssd(patch, region, alpha, center_patch)

patch_size = size(patch);
region_size = size(region);
SSD_region = zeros(region_size(1), region_size(2))

for row = 1+center_patch(1):region_size(1)-center_patch(1)
    for col = 1+center_patch(2):region_size(2)-center_patch(2)
        temp = region(row-center_patch(1):center_patch(1)+row, col-center_patch(2):center_patch(2)+col, :)-patch(:, :, :);
        SSD_region(row,col) = sum(sum(sum(temp.^2)));
        SSD_region(row,col) = exp(-alpha*SSD_region(row,col));      
    end
end