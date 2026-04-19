% load in data
data = readtable('ExampleData.txt');

% data are 0.5Hz, otherwise resample
%data = resample(...);

% run decision system
DecisionSystem(data);