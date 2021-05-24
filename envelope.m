load dataset_BCIcomp1.mat;
X_train = x_train;
[x,y,z]=size(X_train);
n=(1:x)/250;

% plot(n,X_train(:,1,1),n,X_train(:,2,1),n,X_train(:,3,1));
envelope_data=zeros(1152,2,3,140);
for i=1:z
    for j=1:y
    [yupper,ylower] = envelope(X_train(:,j,i),10,'peak');
    envelope_data(:,1,j,i)=envelope_data(:,1,j,i)+yupper;
    envelope_data(:,2,j,i)=envelope_data(:,2,j,i)+ylower;
    end
end
% size(yupper)
% plot(n,yupper,n,ylower,'linewidth',1.5)
% hold on
% plot(n,X_train(:,1,1))


