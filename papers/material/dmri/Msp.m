function M=Msp(m)
% Matrix for sampling pattern m

r=1;
M=zeros(sum(m), length(m));
for i=1:length(m)
    if m(i) == 1
        M(r, i)=1;
        r=r+1;
    end
end