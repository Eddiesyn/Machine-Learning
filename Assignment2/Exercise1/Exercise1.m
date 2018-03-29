load dataGMM;
%% Initialization using K-Means
Center_id = randperm(size(Data,2),4);
D = zeros(4,size(Data,2));
label = zeros(1,size(Data,2));
Centern = Data(:,Center_id);
Centero = zeros(2,4);
diedai1 = 0;
while sum(sum(Centern ~= Centero)) ~= 0
    diedai1 = diedai1+1;
    Centero = Centern;
    for i = 1:4
        D(i,:) = sqrt(sum(bsxfun(@minus,Data,Centero(:,i)).^2,1));
    end
    [~,label] = min(D);
    for j = 1:4
        Centern(:,j) = mean(Data(:,label == j),2);
    end
end
Prior = cell(4,3);
for i = 1:4
    Prior{i,1} = Centern(:,i);
    Prior{i,2} = cov(Data(:,label == i)');
    Prior{i,3} = sum(label == i)/size(Data,2);
end
%% EM-estimation for GMM
Posterior = zeros(size(Data,2),4);
P = zeros(1,4);
M = zeros(2,4);
S = cell(1,4);
for i = 1:4
    P(1,i) = Prior{i,3};
    M(:,i) = Prior{i,1};
    S{1,i} = Prior{i,2};
end
Gaus = @(x,m,s) ((2*pi)^(-size(x,1)))*(det(s)^(-0.5))*exp(-0.5*(x-m)'*pinv(s)*(x-m));
diedai2 = 0;
while pi > 1
    diedai2 = diedai2 + 1;
    Po = P;
    Mo = M;
    So = S;
    for i = 1:size(Data,2)
        Sum = 0;
        for j = 1:4
            Sum = Sum + Po(j)*Gaus(Data(:,i),Mo(:,j),So{1,j});
        end
        for k = 1:4
            Posterior(i,k) = Po(k)*Gaus(Data(:,i),Mo(:,k),So{1,k})/Sum;
        end
    end
    for i = 1:4
        M(:,i) = sum(repmat(Posterior(:,i),1,2)'.*Data,2)/sum(Posterior(:,i),1);
        S{1,i} = (repmat(Posterior(:,i),1,2)'.*(bsxfun(@minus,Data,Mo(:,i))))*bsxfun(@minus,Data,Mo(:,i))'/sum(Posterior(:,i),1);
        P(1,i) = sum(Posterior(:,i),1)/size(Data,2);
    end
    if sum(sum(abs((M - Mo))))+sum(sum(abs((P - Po))))+sum(sum(abs((cell2mat(S) - cell2mat(So))))) <= 1e-6
        break;
    end
end
[~,label] = max(Posterior,[],2);
figure;
gscatter(Data(1,:), Data(2,:), label);
hold on;
for i = 1:4
    [X,Y] = meshgrid(M(1,i)-0.025:0.0005:M(1,i)+0.025,M(2,i)-0.025:0.0005:M(2,i)+0.025);
    Z = mvnpdf([X(:) Y(:)],M(:,i)',S{i});
    Z = reshape(Z,size(X));
    contour(X,Y,Z);
    hold on;
end

