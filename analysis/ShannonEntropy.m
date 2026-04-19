function entropy = ShannonEntropy(vector)
    vector = vector(:);
    [~, ~, idx] = unique(vector);
    counts = accumarray(idx, 1);

    total = length(vector);

    probs = counts / total;
    probs(probs == 0) = [];

    entropy = -sum(probs .* log2(probs));
end