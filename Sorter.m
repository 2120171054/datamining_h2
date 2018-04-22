clear;
format long g;
total_num=5000;
data=importdata('Building_Permits.csv');
attribute_index=1;
pre_index=1;
attribute_total= data.textdata{1,1};
for j=1:length(attribute_total)
    if attribute_total(j) == ','
        attribute{attribute_index}=attribute_total(pre_index:j-1);
        pre_index=j+1;
        attribute_index=attribute_index+1;
    end
end
attribute{attribute_index}=attribute_total(pre_index:end);
data.textdata(1,:)=[];
total_data=cell(198900,43);
total_data(:,1:42)=data.textdata;
total_data(:,43)=num2cell(data.data);
ATTRIBUTES_Number = {'Number of Existing Stories'; 'Number of Proposed Stories'; 'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'}; 
ATTRIBUTES_Nominal_without_Category_Label = {'Permit Number'; 'Permit Creation Date'; 'Block'; 'Lot'; 'Street Number'; 'Street Number Suffix';'Street Name';'Street Suffix';'Unit';'Unit Suffix';'Description';'Current Status';'Current Status Date';'Filed Date';'Issued Date';'Completed Date';'First Construction Document Date';'Structural Notification';'Voluntary Soft-Story Retrofit';'Fire Only Permit';'Permit Expiration Date';'Existing Use';'Proposed Use';'Plansets';'TIDF Compliance';'Site Permit';'Supervisor District';'Neighborhoods - Analysis Boundaries';'Zipcode';'Location';'Record ID'}; 
ATTRIBUTES_Nominal_with_Category_Label = {'Permit Type'; 'Existing Construction Type'; 'Proposed Construction Type'}; 
ATTRIBUTES_Nominal_Category_Label = {'Permit Type Definition'; 'Existing Construction Type Description'; 'Proposed Construction Type Description'}; 
if ~exist('processed_permits.mat','file')
    total_attribute_number=NaN*ones(198900,43);
else
    load('processed_permits.mat');
end
fid=fopen(['data_permits_',num2str(total_num),'.csv'], 'wt');
total_data(:,36)=[];
total_data(:,34)=[];
total_data(:,2)=[];
attribute(36)=[];
attribute(34)=[];
attribute(2)=[];
numi=randperm(198900);
for i=1:total_num
    count=numi(i);
    for j=1:39
        if ~isempty(total_data{count,j})
            if j~=39
                fprintf(fid,'%s:%s,',attribute{j},total_data{count,j});
            else
                fprintf(fid,'%s:%s',attribute{j},total_data{count,j});
            end
        end
    end
    fprintf(fid,'\n');
end
fclose(fid);