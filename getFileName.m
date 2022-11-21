function res = getFileName(app, responses)
    
    % Check if directory exists
    if ~isfolder('data')
        mkdir('data');
    end

    eCode = responses{1};
    sId = responses{2};
    rId = responses{3};

    cDate = datetime;
    cYear = cDate.Year;
    cMonth = cDate.Month;
    cDay = cDate.Day;
    cHour = cDate.Hour;
    cMinute = cDate.Minute;

    nameStr = 'data/SimData_%s_%s_%s_%d%02d%02d_%02d%02d';
    res = sprintf(nameStr, eCode, sId, rId, cYear, cMonth, cDay, cHour, cMinute);

end