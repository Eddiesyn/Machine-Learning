function [ rew,state_list_P ] = WalkPolicyIteration (s)
%% defining reward function
rew = zeros(16,4);
rew(1,:) = [0 -1 0 -1];
rew(2,:) = [0 0 -1 -1];
rew(3,:) = [0 0 -1 -1];
rew(4,:) = [0 -1 0 -1];
rew(5,:) = [-1 -1 0 0];
rew(6,:) = [0 -1 0 -1];
rew(7,:) = [0 -1 0 -1];
rew(8,:) = [-1 1 0 0];
rew(9,:) = [-1 -1 0 0];
rew(10,:) = [0 -1 0 -1];
rew(11,:) = [0 -1 0 -1];
rew(12,:) = [-1 1 0 0];
rew(13,:) = [0 -1 0 -1];
rew(14,:) = [0 0 -1 1];
rew(15,:) = [0 0 -1 1];
rew(16,:) = [0 1 0 1];
save('rew','rew');
%% Applying policy iteration
A = [2 4 5 13;1 3 6 14;4 2 7 15;3 1 8 16;6 8 1 9;5 7 2 10;8 6 3 11;7 5 4 12;10 12 13 5;9 11 14 6;12 10 15 7;11 9 16 8;14 16 9 1;13 15 10 2;16 14 11 3;15 13 12 4];
save('A','A');
policy = zeros(16,1);
policy_new = ceil(rand(16,1)*4);
gama = 0.9;
diedai = 0;
while sum(sum(policy ~= policy_new))~=0
    diedai = diedai + 1;
    policy = policy_new;
    Temp = ones(16,1);
    Temp = diag(Temp);
    R = zeros(16,1);
    for i = 1:16
        R(i,1) = rew(i,policy(i,1));
        Temp(i,A(i,policy(i,1))) = -1*gama;
    end
    V = Temp\R;
    VV = gama*V(A);
    [~,policy_new] = max(VV+rew,[],2);
end
disp(diedai);
state_list_P = zeros(1,16);
i = 1;
state_list_P(1,i) = s;
gait = A(s,policy(s,1));
for i = 2:16
    state_list_P(1,i) = gait;
    gait = A(gait,policy(gait,1));
end
walkshow(state_list_P);
end

    
