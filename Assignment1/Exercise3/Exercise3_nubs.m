function Afterdata = Exercise3_nubs(gesture_l,gesture_o,gesture_x,k)
v = [0.08,0.05,0.02];
gesture = cell(1,3);
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
m = size(gesture{1},1);
Afterdata = cell(3,2);
%% cluster for l
Center = zeros(k,3);
label = ones(m,1);
distortion = zeros(k,1);
Center(1,:) = mean(gesture{1},1);
distortion(1,1) = sum(sum((bsxfun(@minus,gesture{1}(label == 1,:),Center(1,:))).^2,2));
for i = 1:k-1
    [~,pin] = max(distortion);
    pin = min(pin);
    n = size(label(label == pin),1);
    d = zeros(n,2);
    d(:,1) = sqrt(sum((bsxfun(@minus,gesture{1}(label == pin,:),(Center(pin,:) + v)).^2),2));
    d(:,2) = sqrt(sum((bsxfun(@minus,gesture{1}(label == pin,:),(Center(pin,:) - v)).^2),2));
    index = find(label == pin);
    labell = label(index);
    labell(d(:,1) >= d(:,2),1) = i+1;
    label(index) = labell;
    Center(pin,:) = mean((gesture{1}(label == pin,:)),1);
    Center(i+1,:) = mean((gesture{1}(label == i+1,:)),1);
    distortion(i+1,1) = sum(sum((bsxfun(@minus,gesture{1}(label == i+1,:),Center(i+1,:))).^2,2));
    distortion(pin,1) = sum(sum((bsxfun(@minus,gesture{1}(label == pin,:),Center(pin,:))).^2,2));
end
Afterdata{1,1} = label;
Afterdata{1,2} = Center;
figure(1);
for i = 1:k
    plot3(gesture{1}(label == i,1),gesture{1}(label == i,2),gesture{1}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end
%% cluster for o
Center = zeros(k,3);
label = ones(m,1);
distortion = zeros(k,1);
Center(1,:) = mean(gesture{2},1);
distortion(1,1) = sum(sum((bsxfun(@minus,gesture{2}(label == 1,:),Center(1,:))).^2,2));
for i = 1:k-1
    [~,pin] = max(distortion);
    pin = min(pin);
    n = size(label(label == pin),1);
    d = zeros(n,2);
    d(:,1) = sqrt(sum((bsxfun(@minus,gesture{2}(label == pin,:),(Center(pin,:) + v)).^2),2));
    d(:,2) = sqrt(sum((bsxfun(@minus,gesture{2}(label == pin,:),(Center(pin,:) - v)).^2),2));
    index = find(label == pin);
    labell = label(index);
    labell(d(:,1) >= d(:,2),1) = i+1;
    label(index) = labell;
    Center(pin,:) = mean((gesture{2}(label == pin,:)),1);
    Center(i+1,:) = mean((gesture{2}(label == i+1,:)),1);
    distortion(i+1,1) = sum(sum((bsxfun(@minus,gesture{2}(label == i+1,:),Center(i+1,:))).^2,2));
    distortion(pin,1) = sum(sum((bsxfun(@minus,gesture{2}(label == pin,:),Center(pin,:))).^2,2));
end
Afterdata{2,1} = label;
Afterdata{2,2} = Center;
figure(2);
for i = 1:k
    plot3(gesture{2}(label == i,1),gesture{2}(label == i,2),gesture{2}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end
%% cluster for x
Center = zeros(k,3);
label = ones(m,1);
distortion = zeros(k,1);
Center(1,:) = mean(gesture{3},1);
distortion(1,1) = sum(sum((bsxfun(@minus,gesture{3}(label == 1,:),Center(1,:))).^2,2));
for i = 1:k-1
    [~,pin] = max(distortion);
    pin = min(pin);
    n = size(label(label == pin),1);
    d = zeros(n,2);
    d(:,1) = sqrt(sum((bsxfun(@minus,gesture{3}(label == pin,:),(Center(pin,:) + v)).^2),2));
    d(:,2) = sqrt(sum((bsxfun(@minus,gesture{3}(label == pin,:),(Center(pin,:) - v)).^2),2));
    index = find(label == pin);
    labell = label(index);
    labell(d(:,1) >= d(:,2),1) = i+1;
    label(index) = labell;
    Center(pin,:) = mean((gesture{3}(label == pin,:)),1);
    Center(i+1,:) = mean((gesture{3}(label == i+1,:)),1);
    distortion(i+1,1) = sum(sum((bsxfun(@minus,gesture{3}(label == i+1,:),Center(i+1,:))).^2,2));
    distortion(pin,1) = sum(sum((bsxfun(@minus,gesture{3}(label == pin,:),Center(pin,:))).^2,2));
end
Afterdata{3,1} = label;
Afterdata{3,2} = Center;
figure(3);
for i = 1:k
    plot3(gesture{3}(label == i,1),gesture{3}(label == i,2),gesture{3}(label == i,3),plot_color{i},'markersize',5);
    hold on;
end


end

