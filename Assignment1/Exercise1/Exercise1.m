function par = Exercise1(k)
load Data;
Y = Output';
X = Input';
[~,n] = size(Input);
W = cell(k,6);
Error1 = cell(k,6);
Error2 = cell(k,6);
for i = 1:k
    x = X;
    y = Y;
    testx = X(1+(i-1)*n/k:i*n/k,:);
    x(1+(i-1)*n/k:i*n/k,:) = [];
    trainx = x;
    testy = Y(1+(i-1)*n/k:i*n/k,:);
    y(1+(i-1)*n/k:i*n/k,:) = [];
    trainy = y;
    for j = 1:6
        Z = zeros(n-n/k,3*j+1);
        Z(:,1) = 1;
        z = zeros(n/k,3*j+1);
        z(:,1) = 1;
        W{i,j} = zeros(3*j+1,3);
        for m = 1:j
            Z(:,2+3*(m-1)) = trainx(:,1).^m;
            Z(:,3+3*(m-1)) = trainx(:,2).^m;
            Z(:,4+3*(m-1)) = (trainx(:,1).*trainx(:,2)).^m;
            z(:,2+3*(m-1)) = testx(:,1).^m;
            z(:,3+3*(m-1)) = testx(:,2).^m;
            z(:,4+3*(m-1)) = (testx(:,1).*testx(:,2)).^m;
        end
        W{i,j} = (Z'*Z)^-1*(Z'*trainy);
        Pred = z*W{i,j};
        Error1{i,j} = sum(sqrt(sum((testy(:,1:2)-Pred(:,1:2)).^2,2)))/(n/k);
        Error2{i,j} = sum(sqrt((testy(:,3)-Pred(:,3)).^2))/(n/k);
    end
end
Error1 = cell2mat(Error1);
Error2 = cell2mat(Error2);
s1 = sum(Error1,1);
s2 = sum(Error2,1);
p1 = find(s1 == min(s1));
p2 = find(s2 == min(s2));
par = cell(1,3);
Z = zeros(n,3*p1+1);
for i = 1:p1
    Z(:,1) = 1;
    Z(:,2+3*(i-1)) = X(:,1).^i;
    Z(:,3+3*(i-1)) = X(:,2).^i;
    Z(:,4+3*(i-1)) = (X(:,1).*X(:,2)).^i;
end
w1 = (Z'*Z)^-1*(Z'*Y(:,1:2));
Z = zeros(n,3*p2+1);
for i = 1:p2
    Z(:,1) = 1;
    Z(:,2+3*(i-1)) = X(:,1).^i;
    Z(:,3+3*(i-1)) = X(:,2).^i;
    Z(:,4+3*(i-1)) = (X(:,1).*X(:,2)).^i;
end
w2 = (Z'*Z)^-1*(Z'*Y(:,3));
par{1,1} = w1(:,1);
par{1,2} = w1(:,2);
par{1,3} = w2;
save('params','par');
end
