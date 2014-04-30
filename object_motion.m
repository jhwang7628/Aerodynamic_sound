% Synthesize the object motion
function [X,U,vl] = object_motion(T)

U = zeros(length(T),3,4);
X = zeros(size(U));

% Constant velocity motion in x-direction with three partition
for ii = 1:size(U,3)
   U(:,1,ii) = ones(length(T),1);
end 

for ii = 1:size(U,3)
   for jj = 1:size(U,1)
      X(jj,1,ii) = trapz(U(1:jj,1,ii));
   end
end
X(:,2,1) = 0  .*ones(length(T),1,1);
X(:,2,2) = 0.5.*ones(length(T),1,1);
X(:,2,3) = 1.0.*ones(length(T),1,1);
X(:,2,4) = 1.5.*ones(length(T),1,1);


for ii = 1:length(T)
   for jj = 1:4
      vl(ii,jj) = squeeze(norm(U(ii,:,jj)));
   end
end


end
