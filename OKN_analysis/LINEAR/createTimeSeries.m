function [ AMA, AMI, AMD, TMI, TMA, TBP ] = createTimeSeries( extremes , fsampling )
    %% create AMA timeserie
    amaindex = extremes(:,3) == 1;
    AMA = extremes(amaindex,2);
    
    %% create AMI timeserie
    amiindex = extremes(:,3) == -1;
    AMI = extremes(amiindex,2);
    
    %% create AMD timeserie
    max_indexes = find(extremes(:,3) == 1);
    AMD = zeros(length(max_indexes),1);
    for i = 1:length(max_indexes)
        j = max_indexes(i);
        for next_min = j+1 : length(extremes)
            if(extremes(j,3)*extremes(next_min,3)<0)
                break;
            end            
        end
        % we have computed next_mxin index 
        if(extremes(j,3)*extremes(next_min,3)<0)
            AMD(i) = abs(extremes(next_min,2) - extremes(j,2));
        end
    end
    keep = find(AMD>0);
    AMD = AMD(keep);
    
    %% create TMI timeserie
    max_indexes = find(extremes(:,3) == 1);
    TMI = zeros(length(max_indexes),1);
    for i = 1:length(max_indexes)
        j = max_indexes(i);
        for next_min = j+1 : length(extremes)
            if(extremes(j,3)*extremes(next_min,3)<0)
                break;
            end            
        end
        % we have computed next_mxin index 
        if(extremes(j,3)*extremes(next_min,3)<0)
            TMI(i) = extremes(next_min,1) - extremes(j,1);
        end
    end
    keep = find(TMI>0);
    TMI = TMI(keep);
    
    %% create TMA timeserie
    min_indexes = find(extremes(:,3) == -1);
    TMA = zeros(length(min_indexes),1);
    for i = 1:length(min_indexes)
        j = min_indexes(i);
        for next_max = j+1 : length(extremes)
            if(extremes(j,3)*extremes(next_max,3)<0)
                break;
            end            
        end
        % we have computed next_mxin index 
        if(extremes(j,3)*extremes(next_max,3)<0)
            TMA(i) = extremes(next_max,1) - extremes(j,1);
        end
    end
    keep = find(TMA>0);
    TMA = TMA(keep);
    
    %% create TBP timeserie
    max_indexes = find(extremes(:,3) == 1);
    TBP = zeros(length(max_indexes),1);
    for i = 1:length(max_indexes)
        j = max_indexes(i);
        for next_max = j+1 : length(extremes)
            if(extremes(j,3)*extremes(next_max,3)>0)
                break;
            end            
        end
        % we have computed next_mxin index 
        if(extremes(j,3)*extremes(next_max,3)>0)
            TBP(i) = extremes(next_max,1) - extremes(j,1);
        end
    end
    keep = find(TBP>0);
    TBP = TBP(keep);
    
    TMA = TMA./fsampling;
    TMI = TMI./fsampling;
    TBP= TBP./fsampling;
end

