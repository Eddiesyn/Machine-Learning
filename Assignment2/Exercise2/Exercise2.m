A = load('A.txt');
B = load('B.txt');
B = B';
pi = load('pi.txt');
Test = load('Test.txt');
%% Forward Algorithm
llh = ones(1,size(Test,2));
for i = 1:size(Test,2)
    Alpha = zeros(size(Test,1),length(pi));
    Alpha(1,:) = diag(pi)*B(:,Test(1,i));
    for j = 2:size(Test,1)
        Alpha(j,:) = diag(Alpha(j-1,:)*A)*B(:,Test(j,i));
    end
    llh(1,i) = log(sum(Alpha(end,:),2));
end
%% check the gesture
if isempty(find(llh > -120,1))
    disp('All sequences belong to gesture 2!');
elseif isempty(find(llh <= -120,1))
    disp('All sequences belong to gesture 1!');
else
    gesture1_label = find(llh > -120);
    gesture2_label = find(llh <= -120);
end

