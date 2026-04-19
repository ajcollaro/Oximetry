function [class, score] = Predict(model, sats, rate)
    [filtered, validation] = ThresholdFilter(sats, rate);

    if validation > 0
        class = 'Error';
        score = 9999;
        return;
    end

    oximetrics = Oximetrics(filtered.Sats);
    features = [
        CTM(filtered.Sats, 1)
        CTM(filtered.Sats, 3)
        CTM(filtered.Sats, 6)
        LZC(filtered.Sats)
        ShannonEntropy(filtered.Sats)
        ShannonEntropy(filtered.Rate)
        oximetrics.DesatDepth
        oximetrics.CT90
        oximetrics.CT95
        oximetrics.ODI3
        oximetrics.D85
        oximetrics.D90
        oximetrics.Desats
    ]';

    [~, score] = predict(model, features);
    score = score(2);

    if score >= 0
        class = 'Positive';
    else
        class = 'Negative';
    end
end

