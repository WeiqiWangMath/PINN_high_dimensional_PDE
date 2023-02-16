%--- Description ---%
%
% Filename: find_margin.m
% Authors: Ben Adcock and Simone Brugiapaglia 
% 
%
% Description: finds the reduced margin R(S) of a set S (see Sec SM2.3)
%
% Inputs:
% S - an d x n set of multi-indices
%
% Output:
% RS - the reduced margin of S

function RS = find_reduced_margin(S)

%%% find margin %%%

[d,n] = size(S);

MS = [];
for i = 1:n
    
    for j = 1:d
        
        % add e_j to the ith entry of S (both positive and negative direction)
        z1 = S(:,i);
        z1(j) = abs(z1(j)) + 1;
        z2 = S(:,i);
        z2(j) = -abs(z2(j)) - 1;
        
        % test for membership of S
        if ismember(z1',S','rows') == 0
            MS = [MS z1];
        end
        if ismember(z1',S','rows') == 0
            MS = [MS z2];
        end
    end
    
end

MS = (unique(MS','rows'))'; % eliminate repeats

%%% compute reduced margin %%%

RS = [];

for i = 1:size(MS,2)
    
    z = MS(:,i);
    
    flg = 1;
    
    for j = 1:d
        
        if abs(z(j)) > 0
            w = z; w(j) = abs(z(j)) - 1;
            if ismember(w',S','rows') == 0
                flg = 0;
            end
        end
        
    end
    
    if flg == 1
        RS = [RS z];
    end
    
end

end