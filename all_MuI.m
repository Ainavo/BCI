%author:mao date:2020-1203 
%function:Mutual Information
%   input:fea_train(m*n), features that needs to culculate MI.需要提取互信息（MI）的特征
%         label_train(m*1),label that conresponds the features.特征对应的标签
%
%  output:rank(n*2),the first dimension includes the Mutual information values,and the second dimension incoude the index. 第一个维度包括互信息值，第二个维度包括索引
function sort_tmp=all_MuI(fea_train,label_train)
% disp(size(fea_train));140,72
% disp(size(label_train));140,1
n=size(fea_train,1);               
tmp=[];
for i=1:size(fea_train,2)
    MuI=calc_MuI(fea_train(:,i),label_train,n);
%     disp(size(MuI));%1,1
    tmp=[tmp;MuI i]; 
%     disp(size(tmp));72,2:特征值对应下标
end
sort_tmp=sortrows(tmp,'descend');
% disp(sort_tmp);%按MUI的大小降序排列

