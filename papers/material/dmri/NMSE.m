function nmse = NMSE(truth,y)

%{
truth = abs(truth);
y = abs(y);
differ = truth - y;
differ = differ.^2;
truth_mean = mean(truth);
y_mean = mean(y);
nmse = mean(differ)/(truth_mean * y_mean);
%}
%-{
truth=truth(:);y=y(:);
nmse=(norm(truth-y)/norm(truth))^2;
%}