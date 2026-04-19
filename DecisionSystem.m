function DecisionSystem(oximetry)
    addpath('analysis');
    models = load('models.mat');

    [ox1Class, ox1Score] = Predict(models.OX1, oximetry.Sats, oximetry.Rate);
    [ox2Class, ox2Score] = Predict(models.OX2, oximetry.Sats, oximetry.Rate);
        
    fprintf('Oximetry Decision Support\n');
    fprintf('=========================\n\n');
    fprintf('OX1: Predicted Class = %s, Score = %g\n', ox1Class, ox1Score);
    fprintf('OX2: Predicted Class = %s, Score = %g\n\n', ox2Class, ox2Score);
    
    if ox1Score == 9999 || ox2Score == 9999
        fprintf('Error. Please check input data.\n\n');
        return;
    end

    fprintf('Suggest ');

    if ox1Score > 0
        fprintf('expedited PSG or treatment.\n\n');
    elseif ox1Score < 0
        if ox2Score > 0
            fprintf('PSG.\n\n');
        else
            fprintf('monitor.\n\n');
        end
    end
end