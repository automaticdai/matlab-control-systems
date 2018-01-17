function ans_m = pairwise_compute(x, y)

x_size = size(x,1);
y_size = size(y,1);


ans_m = zeros(x_size, y_size);


for j = 1:y_size
    for i = 1:x_size
        ans_m(i,j) = x(i) / y(j);
    end
end

ans_m = ans_m(:);

end
