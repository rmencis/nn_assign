function c = lin_sep_count_recursive(p,n)
    if (p == 1) 
        c = 2;
    elseif (n == 1) 
        c = 2;
    else
        c = lin_sep_count(p-1,n) + lin_sep_count(p-1, n-1);
    end
end