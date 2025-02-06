%% Reading data from the com port
clear
T = 0;
dT = 0.1;


% Define COM port and baud rate
comPort = "COM10";  % Change this to your actual port
baudRate = 115200;  % Adjust according to your device

% Open the serial port
s = serialport(comPort, baudRate, 'DataBits',8,'Parity','none','StopBits',1);

% Configure terminator (if needed)
%configureTerminator(s, "LF"); % Line feed ('\n') as the termination character

% Read formatted data in a loop
while true
    % Read one line of data
    dataLine = read(s, 1,'uint32');

    % Convert string to numeric values
    %values = sscanf(dataLine, '%d, %d, %d');
    %values = sscanf(s, '%d,');

    % Display values
    %fprintf('Read values: %d, %d, %d\n', values(1), values(2), values(3));
    fprintf('Read values: %d\n', dataLine(1));
    figure(1);
    plot(T, dataLine, ' .b'), hold on, grid on;    
    T = T+dT;

    % Pause if needed (to avoid too fast reading)
    %pause(0.1);
end

%% Close the serial port when done (Ctrl+C to break loop and then run this)
clear s;
