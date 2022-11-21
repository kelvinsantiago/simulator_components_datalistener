function collectData(app)

    maxIndex = height(app.emptyContainer);

    % The purpose of the cIndex variable is to keep track of how many packets of
    % data have been received as well as to route that package of data to the
    % corresponding row in the data array initialized. cIndex is also used at the
    % end to determine which rows from data to keep. The elapsedLimit controls how
    % long the data collection loop can remain idle prior to stopping. The tic is
    % used to start a timer that is constantly reset once a data package is
    % received. The timer keeps track of how long it has been since the last package
    % of data was received.
    cIndex = 1;
    packetSize = 92;

    if (app.isUnity.Value)
        packetSize = 120;
    end

    while 1
        
        drawnow;
        if ~app.listenForData
            break
        end
        
        if app.uConn.NumBytesAvailable >= packetSize

            received = uint8(read(app.uConn, packetSize, "uint8"));
            
            if (app.isUnity.Value)
                subjectState = returnProcessedDataUnity(app, received);
            else
                subjectState = returnProcessedData(app, received);
            end
            
            app.simTimeTxtBox.Text = sprintf('%.2f', subjectState(1));
            app.emptyContainer(cIndex,:) = subjectState;

            cIndex = cIndex + 1;

            if cIndex > maxIndex

                fprintf('Data Collection Stopped: Too Much Data Collected\n');
                break 

            end
            
        end

    end
    
    app.emptyContainer = app.emptyContainer(1:cIndex,:);
    app.emptyContainer = app.emptyContainer(app.emptyContainer(:,1) ~= 0,:);
    
    %Save Collected Data
    %colNames = {'simTime', 'simDelta', 'xPos', 'yPos', 'zPos', 'speed', ...
    %'heading', 'steering', 'gas', 'brake', 'SegmentNo', 'Cutin_State', 'Cutin_RoadDistance', ...
    %'Subject_RoadDistance', 'Cutin_RoadOffset', 'Subject_RoadOffset','eulerX','eulerY','eulerZ','rpm','gear', ...
    %'leftBlinker','rightBlinker'};

    colNames = {'simTime', 'simDelta', 'xPos', 'yPos', 'zPos', 'speed', ...
    'heading', 'steering', 'gas', 'brake', 'state1', 'state2', 'state3', ...
    'state4', 'state5', 'state6','eulerX','eulerY','eulerZ','rpm','gear', ...
    'leftBlinker','rightBlinker'};
    
    if (app.isUnity.Value)
        
        colNames = {'simTime', 'simDelta', 'xPos', 'yPos', 'zPos', 'speed', ...
        'heading', 'steering', 'gas', 'brake', 'state1', 'state2', 'state3', ...
        'state4','state5','state6','eulerX','eulerY','eulerZ','rpm','gear', ...
        'leftBlinker','rightBlinker','unityX','unityY','unityZ', ...
        'unityTime', 'unityTimeDelta', 'unityEntity'};

    end

    subjectData = array2table(app.emptyContainer);
    subjectData.Properties.VariableNames = colNames;
    writetable(subjectData, [app.fName, '.csv']);
    
    % Create a MATLAB Table and save it to the disk
    save([app.fName, '.mat'], 'subjectData');
    
end