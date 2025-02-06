%% Reading data from the com port

% clears the com port and everything else

clear 
T = 0;
dT = 0.1;

% Define COM port and baud rate
comPort = "COM10";  % Change this to your actual port
baudRate = 115200;  % Adjust according to your device

% Open the serial port
s = serialport(comPort, baudRate, 'DataBits',8,'Parity','none','StopBits',1);

while true
    % Read one number
    dataLine = read(s, 1,'uint32');

    % Print read data
    fprintf('Read values: %d\n', dataLine(1));
    figure(1);
    plot(T, dataLine, ' .b'), hold on, grid on;    
    T = T+dT;

    % Pause if needed (to avoid too fast reading)
    % pause(0.01);
end


%% Close the serial port when done (Ctrl+C to break loop and then run this)
clear s;
