function Afterdata = Exercise3_kmeans(gesture_l,gesture_o,gesture_x,init_cluster_l,init_cluster_o,init_cluster_x,k)
gesture = cell(1,3);
init_cluster = cell(1,3);
plot_color = cell(1,7);
plot_color{1} = '.b';
plot_color{2} = '.k';
plot_color{3} = '.r';
plot_color{4} = '.g';
plot_color{5} = '.m';
plot_color{6} = '.y';
plot_color{7} = '.c';
gl = permute(gesture_l,[1,3,2]);
go = permute(gesture_o,[1,3,2]);
gx = permute(gesture_x,[1,3,2]);
gesture{1} = gl(:,:,1);
gesture{2} = go(:,:,1);
gesture{3} = gx(:,:,1);
for i = 2:10
    gesture{1} = vertcat(gesture{1},gl(:,:,i));
    gesture{2} = vertcat(gesture{2},go(:,:,i));
    gesture{3} = vertcat(gesture{3},gx(:,:,i));
end    
init_cluster{1} = init_cluster_l;
init_cluster{2} = init_cluster_o;
init_cluster{3} = init_cluster_x;
Afterdata = cell(3,2);
%% cluster for l
m = size(gesture{1},1);
d = zeros(m,k);
label = zeros(m,1);
JL1 = zeros(k,1);
JL2 = zeros(k,1);
Jl = 1;
Center = init_cluster{1};
diedai = 0;
while Jl > 1e-6
    diedai = diedai + 1;
    for i = 1:m
        for j = 1:k
            d(i,j) = sqrt(sum((gesture{1}(i,:) - Center(j,:)).^2));
        end
    end
    
    for i = 1:m
        if size(find(d == min(d(i,:))),1) > 1
            [~,temp] = find(d == min(d(i,:)));
            label(i,1) = min(temp);
        else
            [~,label(i,1)] = find(d == min(d(i,:)));
        end
    end
    
    for i = 1:k
        JL1(i,1) = sum(sum((bsxfun(@minus,gesture{1}(label == i,:),Center(i,:))).^2));
    end
    
    for i = 1:k
        Center(i,:) = mean(gesture{1}(label == i,:),1);
        JL2(i,1) = sum(sum((bsxfun(@minus,gesture{1}(label == i,:),Center(i,:))).^2));
    end
    
    Jl = abs(sum(JL1)-sum(JL2))/sum(JL1);          
end
Afterdata{1,1} = label;
Afterdata{1,2} = Center;
figure(1);
for i = 1:k
    plot3(gesture{1}(label == i,1),gesture{1}(label == i,2),gesture{1}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end
%% cluster for o 
m = size(gesture{2},1);
d = zeros(m,k);
label = zeros(m,1);
JL1 = zeros(k,1);
JL2 = zeros(k,1);
Jl = 1;
Center = init_cluster{2};
diedai = 0;
while Jl > 1e-6
    diedai = diedai + 1;
    for i = 1:m
        for j = 1:k
            d(i,j) = sqrt(sum((gesture{2}(i,:) - Center(j,:)).^2));
        end
    end
    
    for i = 1:m
        if size(find(d == min(d(i,:))),1) > 1
            [~,temp] = find(d == min(d(i,:)));
            label(i,1) = min(temp);
        else
            [~,label(i,1)] = find(d == min(d(i,:)));
        end
    end
    
    for i = 1:k
        JL1(i,1) = sum(sum((bsxfun(@minus,gesture{2}(label == i,:),Center(i,:))).^2));
    end
    
    for i = 1:k
        Center(i,:) = mean(gesture{2}(label == i,:),1);
        JL2(i,1) = sum(sum((bsxfun(@minus,gesture{2}(label == i,:),Center(i,:))).^2));
    end
    
    Jl = abs(sum(JL1)-sum(JL2))/sum(JL1);          
end
Afterdata{2,1} = label;
Afterdata{2,2} = Center;
figure(2);
for i = 1:k
    plot3(gesture{2}(label == i,1),gesture{2}(label == i,2),gesture{2}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end
%% cluster for x
m = size(gesture{3},1);
d = zeros(m,k);
label = zeros(m,1);
JL1 = zeros(k,1);
JL2 = zeros(k,1);
Jl = 1;
Center = init_cluster{3};
diedai = 0;
while Jl > 1e-6
    diedai = diedai + 1;
    for i = 1:m
        for j = 1:k
            d(i,j) = sqrt(sum((gesture{3}(i,:) - Center(j,:)).^2));
        end
    end
    
    for i = 1:m
        if size(find(d == min(d(i,:))),1) > 1
            [~,temp] = find(d == min(d(i,:)));
            label(i,1) = min(temp);
        else
            [~,label(i,1)] = find(d == min(d(i,:)));
        end
    end
    
    for i = 1:k
        JL1(i,1) = sum(sum((bsxfun(@minus,gesture{3}(label == i,:),Center(i,:))).^2));
    end
    
    for i = 1:k
        Center(i,:) = mean(gesture{3}(label == i,:),1);
        JL2(i,1) = sum(sum((bsxfun(@minus,gesture{3}(label == i,:),Center(i,:))).^2));
    end
    
    Jl = abs(sum(JL1)-sum(JL2))/sum(JL1);          
end
Afterdata{3,1} = label;
Afterdata{3,2} = Center;
figure(3);
for i = 1:k
    plot3(gesture{3}(label == i,1),gesture{3}(label == i,2),gesture{3}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end

end

