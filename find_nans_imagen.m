task_type={'MID', 'SST', 'Faces'};
data2impute= {'meanvoldata', 'stdvoldata', 'sumvoldata'};

missing=struct;

for task=1:(size(task_type,2))
    
    for data=1:(size(data2impute,2))
        
        for con=1:(size(eval([task_type{task}]),2))
            clear conname dataname
            conname=['con' num2str(eval([task_type{task} '(' num2str(con) ').cons']))];
            dataname=[data2impute{data}];
            missing(task).(conname).(dataname)=find(isnan(eval([task_type{task} '(' num2str(con) ').' data2impute{data} '(1,:)'])));
        end
    end
end
clear mask sex site data con task invarname structvarname conname data2impute task_type