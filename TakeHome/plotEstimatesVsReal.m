function plotEstimatesVsReal(estimationFunction, realData, numTimePoints)
    % estimationFunction: Function handle to your estimation function
    % realData: Matrix or cell array containing real data
    % numTimePoints: Number of time points to evaluate

    estimatedData = cell(1, numTimePoints); % Initialize cell array

    % Collect estimated data
    for t = 1:numTimePoints
        estimatedData{t} = estimationFunction(t); % Assuming your function takes time as input
    end

    % Now plot
    figure;
    for t = 1:numTimePoints
        subplot(numTimePoints, 1, t);
        hold on;
        % Plot estimated data
        plot(estimatedData{t}, 'o-', 'DisplayName', 'Estimated');
        % Plot real data (assumes realData is a cell array or a matrix with similar structure)
        plot(realData{t}, 'x-', 'DisplayName', 'Real');
        hold off;
        legend;
        title(['Time Point ', num2str(t)]);
        ylabel('Value');
    end
end