load(dir_train_data);
X_train = permute(train_data,[2 1 3]);%交换数组维度
X_test=permute(test_data,[2 1 3]);  %训练集标签
X_train=x_train;
X_test=x_test;
Y_train=y_train;
load(dir_test_label);
Y_test=y_test;  
% % 训练集自测准确度
% x_train = permute(train_data,[2 1 3]);
% X_test=permute(test_data,[2 1 3]);
% X_train = x_train(:,:,1:70);
% X_test=x_train(:,:,71:100);
% Y_train=train_label(1:70);
% Y_test=train_label(71:100);
% load(dir_test_label)
% Y_test=y_test;    %测试集标签
CSPm=20;     %定义CSP-m参数
sampleRate=250;
startTime=0.1;
k=15;       %定义Mutual Select K values
freq=[4 8 12 16 20 24 28 32 36 40]; %设置子频带频率
[FBtrainf,proj,classNum]=FBCSP(X_train(sampleRate*startTime:end,:,:),Y_train,sampleRate,CSPm,freq); %对训练集数据进行FBCSP
kmax=size(FBtrainf,2);      %k不能超过kmax
%%  特征选择
rank=all_MuI(FBtrainf,Y_train);
selFeaTrain=FBtrainf(:,rank(1:k,2));                             %MuI selected train set features
%% 训练模型
SVMModel = fitcsvm(selFeaTrain,Y_train,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');
CVSVMModel = crossval(SVMModel);

% 计算样本外分类错误率和准确率。
classLoss = kfoldLoss(CVSVMModel);
disp('验证准确率:')
acc = (1-classLoss)*100;
sv = SVMModel.SupportVectors;
%     figure
%     gscatter(n,selFeaTrain,Y_train);
%     hold on
%     plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
%     legend('versicolor','virginica','Support Vector')
fbtestf=FBCSPOnline(X_test(sampleRate*startTime:end,:,:),proj,classNum,sampleRate,CSPm,freq);  %对测试集数据进行FBCSP
selFeaTest=fbtestf(:,rank(1:k,2));                               %MuI test set features
Y_predict=predict(SVMModel,selFeaTest)
% 准确率计算：
l=size(Y_predict,1);
p=0;
for i=1:l
   if Y_predict(i)==Y_test(i)
       p=p+1;
   end
end
acrrucy=p/l
ITR=60/4*(log2(size(Y_train,1))+acrrucy*log2(acrrucy)+(1-acrrucy)*log2((1-acrrucy)/(size(Y_train,1)-1)));



