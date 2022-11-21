function res = readSetting(fPath)

    fConn = fopen(fPath, 'r');
    fStr = fgetl(fConn);
    fclose(fConn);
    
    res = strtrim(fStr);

end