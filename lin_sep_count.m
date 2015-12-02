function c = lin_sep_count(p,n)
    if p <= n
        c = 2^p;
    else
        c = 0;
        for i = 0:n-1
           c = c + (factorial(p-1) / (factorial(i)*factorial(p-1-i)));
        end
        c = 2 * c;
    end
end