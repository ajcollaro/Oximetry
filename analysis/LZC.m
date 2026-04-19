function complexity = LZC(vector)
    vector = vector(:);
    length = numel(vector);
    phrases = 1;
    index = 2;

    while index <= length
        longestMatch = 0;

        for i = 1:(index - 1)
            k = 0;
            while index + k <= length && ...
                  i + k <= length && ...
                  vector(i + k) == vector(index + k)
                k = k + 1;
            end

            if k > longestMatch
                longestMatch = k;
            end
        end

        index = index + longestMatch + 1;

        if index <= length
            phrases = phrases + 1;
        end
    end

    complexity = phrases / length;
end