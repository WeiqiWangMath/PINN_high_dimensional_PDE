
function y = exp_cos_fcn(k,x)

[m,d] = size(x);
y = ones(m,1);

for i = 1 : d
    y = y .* (exp( (cos((k(i)*2 + 1) * pi/2 * x(:,i)))) - 1);
end

end