port = 'COM3'; % Arduino's COM port
baudRate = 9600;
bufferSize = 10000; % Number of data points to display on the graph

% serial communication
arduino = serialport(port, baudRate);

% Configure serial port timeout
configureTerminator(arduino, "LF"); % Match with Serial.println in Arduino

% Preallocate buffer
ecgData = zeros(1, bufferSize);
t = linspace(0, bufferSize-1, bufferSize);

% Setup figure
figure;
h = plot(t, ecgData);
xlabel('Sample Index');
ylabel('ECG Signal');
title('Real-Time ECG Signal');
grid on;

% Real-time data collection and plotting
while isvalid(h)
    try
        % Read data from Arduino
        rawData = readline(arduino);
        ecgValue = str2double(rawData);

        if ~isnan(ecgValue)
            % Update the buffer
            ecgData = [ecgData(2:end), ecgValue];
            
            % Update the plot
            set(h, 'YData', ecgData);
            drawnow;
        end
    catch ME
        disp("Error reading data: " + ME.message);
        break;
    end
end

% Clean up
clear arduino;
