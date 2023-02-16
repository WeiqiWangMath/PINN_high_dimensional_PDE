%Visualize 2D HC index set Fig 1,2

figure(1);
I = generate_index_set('HC',2,38); 
I(:,223) = []; 
figure(1);
plot(I(1,:),I(2,:),'.')
axis on;
xlabel('x');
ylabel('y');

figure(2);
I = generate_index_set('HC',3,24); 
I(:,388) = []; 
plot3(I(1,:),I(2,:),I(3,:),'.');
axis on;
xlabel('x');
ylabel('y');
zlabel('z');
