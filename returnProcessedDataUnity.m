function res = returnProcessedDataUnity(app, received)

    % 30 fields are returned

    simTime = typecast(received(1:4), 'single');
    simDelta = typecast(received(5:8), 'single');

    xPos = typecast(received(9:12), 'single');
    yPos = typecast(received(13:16), 'single');
    zPos = typecast(received(17:20), 'single');

    speedVal = typecast(received(21:24), 'single');
    headingVal = typecast(received(25:28), 'single');

    steerVal = typecast(received(29:32), 'single');
    gasPedalVal = typecast(received(33:36), 'single');
    brakePedalVal = typecast(received(37:40), 'single');
    
    state1 = typecast(received(41:44), 'single');
    state2 = typecast(received(45:48), 'single');
    state3 = typecast(received(49:52), 'single');
    state4 = typecast(received(53:56), 'single');
    state5 = typecast(received(57:60), 'single');
    state6 = typecast(received(61:64), 'single');

    eulerX = typecast(received(65:68), 'single');
    eulerY = typecast(received(69:72), 'single');
    eulerZ = typecast(received(73:76), 'single');

    rpm    = typecast(received(77:80), 'single');
    gear   = typecast(received(81:84), 'single');

    leftBlinker = typecast(received(85:88), 'single');
    rightBlinker = typecast(received(89:92), 'single');

    unityX = typecast(received(93:96), 'single');
    unityY = typecast(received(97:100), 'single');
    unityZ = typecast(received(101:104), 'single');

    unityTime = typecast(received(105:108), 'single');
    unityTimeDelta = typecast(received(109:112), 'single');
    unityEntity = typecast(received(113:116), 'single');
    endOfRowBytes = typecast(received(117:120), 'single');

    toRet = [
        simTime, simDelta, ...
        xPos, yPos, zPos, speedVal, headingVal, ...
        steerVal, gasPedalVal, brakePedalVal, ...
        state1, state2, state3, state4, state5, state6, ...
        eulerX, eulerY, eulerZ, rpm, gear, leftBlinker, rightBlinker, ...
        unityX, unityY, unityZ, unityTime, unityTimeDelta, unityEntity
    ];
    
    try
       
        %Speed is received in m/s
        app.SpeedGauge.Value = speedVal*2.2369;
        %app.SpeedGauge.Label = sprintf('Speed: %.0f', speedVal);

        app.BrakeGauge.Value = brakePedalVal;
        %app.BrakeGauge.Label = sprintf('Brake: %.0f', brakePedalVal);

        app.GasGauge.Value = gasPedalVal;
        %app.GasGauge.Label = sprintf('Gas: %.0f', brakePedalVal);

        app.SteerGauge.Value = steerVal;
        %app.SteerGauge.Label = sprintf('Steer: %.0f', brakePedalVal);
        
    catch ME
        
        disp("Error when updating gauges.");
        
    end
    
    res = toRet;

end