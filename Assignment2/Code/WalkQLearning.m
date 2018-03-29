function  [ state_list_Q ] = WalkQLearning(s)

% Q = zeros(16,4);
E = 0.2;
a = 0.8;
gama = 0.9;
% diedai = 0;
Q = zeros(16,4);
state = s;
% Q = ones(16,4);
T = 1500;

for t = 1:T
%     Q = Q_new;
%     diedai = diedai+1;
        test = rand();
    if test > E
        if size(unique(Q(state,:)),2) == 1
            p = ceil(rand()*4);
        else
            [~,p] = max(Q(state,:),[],2);
        end
    else
        p = ceil(rand()*4);
    end

    [ss,r] = SimulateRobot(state,p);
    Q(state,p) = Q(state,p) + a*(r + gama*max(Q(ss,:),[],2) - Q(state,p));
    state = ss;
end

state_list_Q = zeros(1,16);
state_list_Q(1,1) = s;
state = s;
for i = 2:16
    [~,p] = max(Q(state,:),[],2);  
    [ss,~] = SimulateRobot(state,p);
    state_list_Q(1,i) = ss;
    state = ss; 
end
walkshow(state_list_Q);

end

