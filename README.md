## This is the implementation of "Matching local self-similarities across images and videos"
## Introduction
1  main：The main function includes reading the image, calculating the self-similarity descriptor of each picture, calculating the saliency score, and drawing the detection result; 

2  com_Self_Similarities：Calculate the self-similarity descriptor;

    2.1  cal_ssd：Calculate the SSD between patch and region；
    
    2.2  get_self_sim_vec：Convert the similarity calculated in 2.1 to a self-similarity descriptor vector;
    
    2.3  cart2polar： Convert Cartesian coordinates to a polar coordinate system; 
    
    2.4  get_bin：Divide the polar coordinate system into 15*3=45 bins;
    
3  draw_result：Show results.

## Result
![detect common](https://github.com/qibao77/Detect-the-common-of-images/blob/master/result/detect%20common.png)

## Reference
Shechtman E, Irani M. Matching local self-similarities across images and videos[C]//2007 IEEE Conference on Computer Vision and Pattern Recognition. IEEE, 2007: 1-8.
