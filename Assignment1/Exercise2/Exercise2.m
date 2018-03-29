function [ d,Minerror,CM ] = Exercise2( dmax )
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
testi = loadMNISTImages('t10k-images.idx3-ubyte');
testl = loadMNISTLabels('t10k-labels.idx1-ubyte');
n1 = size(images,2);
n2 = size(testi,2);
M = repmat(mean(images,2),1,n1);
C = cov((images-M)',1);
[V,D] = eig(C);
[~,index] = sort(diag(D),'descend');
% N = zeros(1,10);
% m = cell(1,10);
% c = cell(1,10);
lh = zeros(10,n2);
testlabel = zeros(dmax,n2);
Error = zeros(dmax,1);
for i = 1:dmax
    CP = V(:,index(1:i))';
    I = CP * images;
    TI = CP * testi;
    for j = 1:10
        N = size(find(labels == j-1),1);
        CL = I(:,labels == j-1);
        m = mean(CL,2)';
        c = cov((CL-repmat(mean(CL,2),1,N))',1);
        lh(j,:) = mvnpdf(TI',m,c);
    end
    [~,testlabel(i,:)] = max(lh);
end
testlabel = testlabel - 1;
for i = 1:dmax
    Error(i,1) = size(find((testlabel(i,:) == testl')==0),2)/n2;
end
[~,d] = min(Error);
Minerror = Error(d,1);
CM = confusionmat(testl,testlabel(48,:)');
figure;
plot(Error);
xlabel('the value of d');
ylabel('classification error');

end

