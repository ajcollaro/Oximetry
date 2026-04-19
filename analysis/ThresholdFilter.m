function [filtered, validation] = ThresholdFilter(sats, rate)
    lengthMax = 25200;
    lengthMin = 10800;
    rateMax = 230;
    rateMin = 40;
    satsMax = 100;
    satsMin = 60;

    filtered.Sats = [];
    filtered.Rate = [];

    if length(sats) ~= length(rate)
        validation = 1;
        return;
    end

    try
        validIdx = sats >= satsMin & sats <= satsMax & ...
                   rate >= rateMin & rate <= rateMax;

        filtered.Sats = round(sats(validIdx));
        filtered.Rate = round(rate(validIdx));

        if length(filtered.Sats) < lengthMin
            validation = 1;
        elseif length(filtered.Sats) > lengthMax
            validation = 2;
        else
            validation = 0;
        end
    catch
        validation = 2;
    end
end