

function y = rand_poly_fcn(k,x)

[m,d] = size(x);
y = ones(m,1);

for i = 1 : d
    y = 2 * y .* (1-x(:,i)).^k(i) .*(1+x(:,i));
end

end