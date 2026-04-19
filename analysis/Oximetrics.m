function oximetrics = Oximetrics(vector)
    averaging = 90;
    flagInitial = 1;
    flagDecayRate = 0.2;

    oximetrics.Baseline = 0;
    oximetrics.CT90 = 0;
    oximetrics.CT95 = 0;
    oximetrics.D85 = 0;
    oximetrics.D90 = 0;
    oximetrics.DesatDepth = 0;
    oximetrics.Desats = 0;
    oximetrics.ODI3 = 0;

    flagD85 = 0;
    flagD90 = 0;
    flagDesats = 0;
    flagODI3 = 0;

    vectorMut = vector(:);
    filtered = [];
    vectorAccum = 0;

    for i = 2:length(vectorMut)
        current = vectorMut(i);

        if current < 90
            oximetrics.CT90 = oximetrics.CT90 + 1;
        end
        if current < 95
            oximetrics.CT95 = oximetrics.CT95 + 1;
        end

        if i > averaging
            vectorSlice = vectorMut(i - averaging + 1:i);
            vectorBaseline = median(vectorSlice);
        else
            vectorBaseline = 0;
        end

        vectorDelta = vectorMut(i) - vectorMut(i - 1);
        if vectorDelta <= 0
            vectorAccum = vectorAccum + vectorDelta;
        else
            vectorAccum = 0;
        end

        flagD85 = flagD85 - flagDecayRate;
        flagD90 = flagD90 - flagDecayRate;
        flagDesats = flagDesats - flagDecayRate;
        flagODI3 = flagODI3 - flagDecayRate;

        if vectorAccum <= -3 && flagDesats <= 0
            oximetrics.Desats = oximetrics.Desats + 1;
            flagDesats = flagInitial;
        end

        if flagODI3 > 0 && current < vectorBaseline
            oximetrics.DesatDepth = oximetrics.DesatDepth + (vectorBaseline - current);
        end

        if vectorAccum <= -3 && current < (vectorBaseline - 3)
            if flagODI3 <= 0
                oximetrics.DesatDepth = oximetrics.DesatDepth + 3;
                oximetrics.ODI3 = oximetrics.ODI3 + 1;
                flagODI3 = flagInitial;
            end

            if current < 90 && flagD90 <= 0
                oximetrics.D90 = oximetrics.D90 + 1;
                flagD90 = flagInitial;
            end

            if current < 85 && flagD85 <= 0
                oximetrics.D85 = oximetrics.D85 + 1;
                flagD85 = flagInitial;
            end
        end

        if flagODI3 <= 0
            filtered(end+1) = current;
        end
    end

    correction = floor(length(vectorMut) / 30 / 60);

    if ~isempty(filtered)
        oximetrics.Baseline = median(filtered);
    else
        oximetrics.Baseline = 0;
    end

    oximetrics.CT90 = oximetrics.CT90 / correction;
    oximetrics.CT95 = oximetrics.CT95 / correction;
    oximetrics.DesatDepth = oximetrics.DesatDepth / correction;
    oximetrics.ODI3 = oximetrics.ODI3 / correction;
    oximetrics.Desats = oximetrics.Desats / correction;
end
