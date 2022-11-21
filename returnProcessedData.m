function res = returnProcessedData(app, received)

    %16 fields are returned.

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

    toRet = [
        simTime, simDelta, ...
        xPos, yPos, zPos, speedVal, headingVal, ...
        steerVal, gasPedalVal, brakePedalVal, ...
        state1, state2, state3, state4, state5, state6, ...
        eulerX, eulerY, eulerZ, rpm, gear, leftBlinker, rightBlinker
    ];
    
    try
       
        app.SpeedGauge.Value = speedVal;
        app.BrakeGauge.Value = brakePedalVal;
        app.GasGauge.Value = gasPedalVal;
        app.SteerGauge.Value = steerVal;
        
    catch ME
        
        disp("Error when updating gauges.");
        
    end
    
    res = toRet;

end