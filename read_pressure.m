function g = cal_g   

Y = read_pressure;

drag = zeros(size(Y,3),2); % x force, y force
g    = zeros(size(Y,3),2);

dt   = 0.001; % got from fluent

for ii = 1:size(Y,3)
   drag(ii,1) = sum(Y(:,2,ii).*Y(:,3,ii));
   drag(ii,2) = sum(Y(:,2,ii).*Y(:,4,ii));
end

% Finite-difference for the time derivatives of the greens function
for jj = 1:2
   g(2:end-1,jj) = (drag(3:end,jj) - drag(1:end-2,jj))/2/dt;
   g(1,  jj) = (4.*g(2    ,jj) - g(3    ,jj) - 3.*g(1  ,jj))/2/dt;
   g(end,jj) =-(4.*g(end-1,jj) - g(end-2,jj) - 3.*g(end,jj))/2/dt;
end

end

%%%%%%%%%%

function Y = read_pressure


Y = zeros(196,4,300);

for ii = 1:300

   data_num = sprintf('./data/FFF-0%4.1f',350.1+ii);
   if ii == 1
      data0 = data_num;
   end

   A = dlmread(data_num,'',1,0); % Read without header
   Y(:,1,ii) = A(:,1); % Cell number
   Y(:,2,ii) = A(:,4); % Pressure
   Y(:,3,ii) = A(:,8); % X-face-area
   Y(:,4,ii) = A(:,9); % Y-face-area

end

fprintf(['Data from ', data0, ' to ', data_num, ' were read to the system.\n']);


end

