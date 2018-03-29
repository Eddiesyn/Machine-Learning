function WalkPolicyIteration(s)

%% Reward- and Transition Matrix
load('rew.mat');
R = rew;
load('A.mat');
delta = A;

%% Policy Iteration
% Discounter factor
gamma = 0.8;

% Initialize the policy randomly
policy = ceil(rand(16,1)*4);

% Use policy_old to store the policy, when doing updated.
policy_old = zeros(16,1);

% Times of iteration
p = 0;


while isequaln(policy, policy_old) == 0
    p = p + 1;
    % Save the policy before update
    policy_old = policy;
    % Create a vector with 16 symbolic variables
    V = sym('v', [16,1]);
    % Build equations
    for i = 1:16
        eqn(i) = V(i) == R(i, policy(i)) + gamma*V(delta(i, policy(i)));
    end
    % Convert the linear equations to matrix notation
    [A,b] = equationsToMatrix(eqn, V);
    % Solve the equations and convert it to double
    V = double(linsolve(A,b));
    % Update the policy
    for i = 1:16
        [~,policy(i)] = max(R(i,:)' + gamma*V(delta(i,:))); %columnswise
    end
end
% Display the iteration times for the policy interation to converge
fprintf('Approximately %d iterations are required for the policy iteration to converge\n',p);

%% Simulation
T = 16;

states = zeros(1,T);

% Calculate the sequence of states according to the policy
states(1) = s;
for i = 2:T
    states(i) = delta(states(i-1), policy(states(i-1)));
end
walkshow(states);
end
