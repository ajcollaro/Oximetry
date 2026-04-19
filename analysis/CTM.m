function result = CTM(vector, radius)
    vector = vector(:);
    length = numel(vector);
    count = 0;

    for i = 1:(length - 2)
        x = vector(i + 1) - vector(i);
        y = vector(i + 2) - vector(i + 1);

        if x^2 + y^2 < radius^2
            count = count + 1;
        end
    end

    if count > 0
        result = count / (length - 2);
    else
        result = 0;
    end
end